# Week 5 — application generation

Everything generated for Week 5 ("your skill reorganised, and your own app"),
collected in one place for presenting. The working originals live in this
repository at `projects/week-04-chinese_emperors/` — run everything from
there (the app reads the database by relative path, so the copies here are
for reading and submission, not for running).

## Challenge 1 — reorganise your skill (`skill/`)

| File | Role |
|---|---|
| `skill/SKILL.md` | the short index: which file to read for which job |
| `skill/what-it-does.md` | how the skill answers questions (workflow, schema, query recipes) |
| `skill/how-to-maintain.md` | how to add new material, step by step |
| `skill/principles.md` | the rules that always hold: rubric 0-4, dates, names, counting |

One job per file; files point to each other instead of repeating.

## Challenge 4 — your own app (`app/`)

"Ask the Chinese Emperors Database": type a question in English or
Traditional Chinese; the server retrieves the matching rows from the
traditional-Chinese CSV exports, gives only those rows plus the rubric
rules to the real DeepSeek model, and shows a cited answer together with
the exact rows the model saw.

| File | Role |
|---|---|
| `app/server.py` | retrieval from the CSVs + the real DeepSeek call (replaces the demo's fixture) + the HTTP server |
| `app/static/index.html` | the page: question box, cited answer, rows-used panel |
| `app/README.md` | what it is, how to run it, where the fixture was |

Run from the project root in a new terminal (so `DEEPSEEK_API_KEY` is set):

```sh
python code/app/server.py    # then open http://localhost:8000
```

## Supporting files

- `code/test_skill.py` — verifies the skill's own claims (files exist, documented queries run, traditional characters); updated for the new file names.
- `research/research_journal.md` — the project journal; the 2026-10-06 entries record the skill restructure and the app build.

## Challenge status

- 1 reorganise the skill — done (commit `cfe3da8`)
- 2 keep every version — done: 5 commits with what-and-why messages, pushed to the fork
- 3 DeepSeek API key — done: stored as the `DEEPSEEK_API_KEY` environment variable, never in Git
- 4 build your own app — done (commit `365ef9d`), tested live
- 5 Blender MCP — optional, not attempted
