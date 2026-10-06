"""Week 5 app: ask the Chinese emperors database.

Run from anywhere (no packages to install):

    python code/app/server.py            (then open http://localhost:8000)
    PORT=8765 python code/app/server.py  (if 8000 is already in use)

The page sends the visitor's question to POST /api/ask. The server loads
the three traditional-Chinese CSV exports, retrieves the rows that could
answer the question, and gives ONLY those rows to the real DeepSeek model
together with the project's answering rules. The model's answer is sent
back with the exact rows it used, so every claim can be checked.

Where the week-05 demo had its fixture (ask_model() returning a saved
file), this app makes a real API call to DeepSeek. The API key comes from
the DEEPSEEK_API_KEY environment variable, never from a file in Git.
"""

import csv
import json
import os
import re
import urllib.request
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
ARTIFACTS = ROOT / "artifacts"
STATIC = Path(__file__).resolve().parent / "static"
PORT = int(os.environ.get("PORT", "8000"))
MODEL = "deepseek-chat"
API_URL = "https://api.deepseek.com/chat/completions"


def load(name):
    with open(ARTIFACTS / f"chinese_emperors_{name}_trad.csv",
              encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))


DYN = load("dynasties")
RUL = load("rulers")
ERA = load("era_names")
DYN_BY_ID = {d["id"]: d for d in DYN}
RUL_BY_ID = {r["id"]: r for r in RUL}

RULES = """You answer questions about every ruler of China, 221 BCE - 1912 CE,
using ONLY the rows provided below from a historical database. Non-negotiable rules:

1. No row, no sentence. Every factual claim must trace to a provided row and
   carry its [id] and source, e.g. [265: Mingshi, annals juan 20-22]. Do not use
   your own knowledge of Chinese history; it is not a data source.
2. If the provided rows cannot answer the question, say "the data has no
   answer" — do not fill in with common knowledge.
3. All Chinese in the answer is Traditional, in the characters the rows use.
4. Rival states overlap: "who was emperor in year X" can have several true
   answers — give them all, by state.
5. Years are integers, negative = BCE (-221 is 221 BCE). There is no year 0.
6. When asked "how many", state the counting rule before the number: every
   holder of supreme sovereign title 221 BCE - 1912 CE counts (kings of the
   Ten Kingdoms, deposed and short-reign rulers, Wu Zetian, child emperors,
   rulers of rival states); regents who never took the title do not.
7. If a row doubts itself (note with "to verify" or disputed dates), pass the
   doubt on as-is.
8. Reply in the language the question is written in."""

STATS = {
    "dynasties": len(DYN),
    "rulers": len(RUL),
    "era_names": len(ERA),
    "note": "row counts computed by the server from the CSV exports",
}


def cjk_runs(text):
    return re.findall(r"[\u4e00-\u9fff]+", text)


def ruler_haystack(r):
    return {
        "cn": " ".join(v for v in (r["personal_name_cn"], r["temple_name"],
                                   r["posthumous_name"]) if v),
        "en": " ".join(v for v in (r["personal_name"], r["temple_name"],
                                   r["posthumous_name"]) if v).lower(),
    }


def retrieve(question):
    """Pick the rows that could answer this question, with the links that
    make them meaningful (a ruler's dynasty, eras, predecessor, successors)."""
    picked = {}

    def add(table, row):
        key = (table, row["id"])
        if key not in picked:
            picked[key] = dict(row, _table=table)

    years = [int(y) for y in re.findall(r"-?\d{1,4}", question)]
    runs = cjk_runs(question)
    words = [w.lower() for w in re.findall(r"[A-Za-z][A-Za-z'\-]+", question)
             if len(w) >= 3]

    ruler_hits = []
    for r in RUL:
        hay = ruler_haystack(r)
        hit = (any(run in hay["cn"] for run in runs)
               or any(w in hay["en"] for w in words)
               or any(int(r["year_start"]) <= y <= int(r["year_end"])
                      for y in years))
        if hit:
            ruler_hits.append(r)
    for r in ruler_hits[:30]:
        add("rulers", r)
        if r["dynasty_id"] in DYN_BY_ID:
            add("dynasties", DYN_BY_ID[r["dynasty_id"]])
        if r["predecessor_id"] in RUL_BY_ID:
            add("rulers", RUL_BY_ID[r["predecessor_id"]])
        for succ in RUL:
            if succ["predecessor_id"] == r["id"]:
                add("rulers", succ)
        for e in ERA:
            if e["ruler_id"] == r["id"]:
                add("era_names", e)

    for d in DYN:
        cn, en = d["name_cn"], d["name"].lower()
        if (any(run in cn or cn in run for run in runs if len(run) >= 2)
                or any(w == en for w in words)
                or any(int(d["year_start"]) <= y <= int(d["year_end"])
                       for y in years)):
            add("dynasties", d)

    for e in ERA:
        cn, en = e["name_cn"], e["name"].lower()
        if (any(run == cn for run in runs)
                or any(w == en for w in words)):
            add("era_names", e)
            if e["ruler_id"] in RUL_BY_ID:
                add("rulers", RUL_BY_ID[e["ruler_id"]])

    return list(picked.values())


def ask_deepseek(question, rows):
    key = os.environ.get("DEEPSEEK_API_KEY", "")
    if not key:
        raise RuntimeError("DEEPSEEK_API_KEY is not set in this environment")
    rows_block = json.dumps(rows, ensure_ascii=False, indent=1)
    prompt = (f"Database rows that may answer the question "
              f"(the ONLY rows you may use):\n{rows_block}\n\n"
              f"Row counts (computed by the server): {json.dumps(STATS, ensure_ascii=False)}\n\n"
              f"Question: {question}")
    body = json.dumps({
        "model": MODEL,
        "messages": [
            {"role": "system", "content": RULES},
            {"role": "user", "content": prompt},
        ],
        "temperature": 0.3,
        "max_tokens": 1200,
    }).encode("utf-8")
    req = urllib.request.Request(
        API_URL, data=body, method="POST",
        headers={"Authorization": f"Bearer {key}",
                 "Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=90) as resp:
        data = json.loads(resp.read().decode("utf-8"))
    return data["choices"][0]["message"]["content"]


class Handler(BaseHTTPRequestHandler):

    def _send(self, code, payload, ctype="application/json; charset=utf-8"):
        data = payload if isinstance(payload, bytes) else \
            json.dumps(payload, ensure_ascii=False).encode("utf-8")
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(data)))
        self.end_headers()
        self.wfile.write(data)

    def do_GET(self):
        if self.path in ("/", "/index.html"):
            self._send(200, (STATIC / "index.html").read_bytes(),
                       "text/html; charset=utf-8")
        else:
            self._send(404, {"error": "not found"})

    def do_POST(self):
        if self.path != "/api/ask":
            self._send(404, {"error": "not found"})
            return
        length = int(self.headers.get("Content-Length", 0))
        question = json.loads(
            self.rfile.read(length).decode("utf-8")).get("question", "").strip()
        if not question:
            self._send(400, {"error": "empty question"})
            return
        rows = retrieve(question)
        try:
            answer = ask_deepseek(question, rows)
        except Exception as exc:
            self._send(502, {"error": f"model call failed: {exc}"})
            return
        self._send(200, {"answer": answer, "rows": rows,
                         "model": MODEL, "stats": STATS})

    def log_message(self, fmt, *args):
        pass


if __name__ == "__main__":
    print(f"serving on http://localhost:{PORT} — model: {MODEL}")
    ThreadingHTTPServer(("127.0.0.1", PORT), Handler).serve_forever()
