# App: ask the Chinese emperors database

A page anyone can open in a browser, backed by a small Python server that
asks the **real** DeepSeek model and reads the Week 4 database. Type a
question in plain language (English or Traditional Chinese); the server
retrieves the rows that could answer it, gives only those rows to the
model together with the project's answering rules
(`../../skills/principles.md`), and returns a cited answer plus the exact
rows used.

```sh
python code/app/server.py            # from the project root; open http://localhost:8000
PORT=8765 python code/app/server.py  # if 8000 is already in use
```

Python standard library only; nothing to install. The API key comes from
the `DEEPSEEK_API_KEY` environment variable — keep it out of Git.

| File | What it does |
|---|---|
| `static/index.html` | the page: a question box, the cited answer, and a collapsible list of the rows the model saw |
| `server.py` | retrieves matching rows from the three trad CSV exports, calls DeepSeek at `POST /api/ask`, returns answer + rows |

## Where the demo's fixture was

The Week 5 demo (`508-coursework/week-05/demo-building-app/`) has an
`ask_model()` that never calls a model — it returns a saved fixture for
every photo. This app replaces that spot with a real DeepSeek API call
(`ask_deepseek()` in `server.py`): the model is told it may use only the
retrieved rows, must cite `[id: source]` for every claim, and must say
"the data has no answer" rather than reach for its own knowledge — the
same rubric the skill is scored by.
