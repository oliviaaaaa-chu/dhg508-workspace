# Research Journal

- [Design Document](../design/design_doc.md)

## 2026-10-06

### DeepSeek key registered, ask-the-database app built (Week 5, challenges 3-4)

- Challenge 3: DeepSeek API key created at platform.deepseek.com and stored
  as the `DEEPSEEK_API_KEY` environment variable (user level) — never in a
  file that goes into Git. Verified with a minimal live call.
- Challenge 4: new app at `code/app/` — `server.py` (stdlib only) +
  `static/index.html`. The page takes a question in English or Traditional
  Chinese; the server retrieves matching rows from the three trad CSV
  exports (name/title/year/era matching, then each hit ruler's dynasty,
  eras, predecessor and successors), and calls the real deepseek-chat API
  with the rubric rules and ONLY those rows. The answer comes back cited
  [id: source], with the exact rows shown on the page for checking.
- Where the demo had its fixture (saved model-response.json returned for
  every photo), this app makes the real API call (`ask_deepseek()`).
- Live tests: "Who ruled in 1127?" -> 15 rows, four rulers by state, all
  cited; "Who followed 嬴政?" -> 3 rows, 胡亥 cited [2: Shiji, juan 6].
  Also observed the rubric working under failure: a test with broken
  character encoding produced zero rows and the model answered "the data
  has no answer" instead of filling in from its own knowledge.
- `code/test_skill.py` still passes (44/280/35, all patterns run).

### Skill reorganised into an index and three documents (Week 5, challenge 1)

- Restructured the skill per the Week 5 instructions: `SKILL.md` is now a
  short index that routes by job — answering → `skills/what-it-does.md`,
  extending the database → `skills/how-to-maintain.md`, the rules that
  always hold → `skills/principles.md`.
- `what-it-does.md` folds in the old `skills/tables.md` (schema) and
  `skills/queries.md` (Python-on-CSV patterns) plus the answering workflow;
  `how-to-maintain.md` is the old `skills/adding-data.md`; `principles.md`
  merges the old `skills/conventions.md` with the rubric rules 0-4 that
  used to sit inside `SKILL.md`.
- Old four files deleted — their content lives in the new three; no
  duplicates. `code/test_skill.py` updated to check the new filenames.
- Substantive content unchanged; only routing, cross-references and one
  counting fix (five, not four, states romanise as "Han").

## 2026-09-29

### Live test failed — rubric embedded into SKILL.md (improvement-log entry 6)

- The user's cold run of the skill answered from general knowledge — the
  rubric's automatic-fail case. Root cause: SKILL.md said what to do but
  not what NOT to do with the model's own historical knowledge.
- Fix: rubric criteria (grounded / cited / honest limits / right question)
  now live inside SKILL.md as enforced rules 0-4, with the hard gate first
  and the explicit negative: general knowledge is exactly what must not
  appear; no row, no sentence; uncited = invented.
- Re-test after: 「武則天是唯一的女皇帝嗎」now answers scoped to the data's
  range with [140] cited instead of a bare general-knowledge "yes".
- improvement-log.md entry 6 records trigger/wrong/changed/after.

### Skill switched to the traditional-Chinese CSVs

- `SKILL.md` rewritten: the only data source is now the three
  traditional-Chinese CSV exports (`*_trad.csv`, read with Python's csv
  module); the simplified exports and the SQLite file are for the build
  pipeline only, never for answering.
- New language rule: answers in English; Traditional Chinese for personal
  names, titles, era names, state names and quotes — and full Traditional
  Chinese when the user writes in Chinese.
- Supporting files made consistent: `skills/queries.md` rewritten as
  Python-on-CSV patterns; `skills/tables.md` and `skills/conventions.md`
  now use traditional characters (劉裕， 萬曆， 朱祁鎮…); `skills/adding-data.md`
  marks the re-export step as mandatory (a stale CSV = outdated answers).
- `code/test_skill.py` rewritten to verify the skill's own claims: the three
  trad CSVs load (44/280/35), every documented query pattern runs, and era
  21 comes back as 萬曆 in traditional characters.

### Improvement log written (challenge 5)

- `improvement-log.md` (project root): 5 entries — mojibake (trigger: a
  Chinese query returning None), missing Tang→Later Liang link (trigger:
  "who followed Li Zhu" → empty), 杨侗's death year (trigger: consistency
  sweep), the restored-emperor chain rebuilt twice (trigger: era +
  predecessor checks), and the duplicate-name build failure.
- Pattern noted in the log: three of five errors were invisible at insert
  time; only the build→check→export routine catches them. Future entries
  must start with a trigger from that routine.
- Challenge 5 done with 5 entries (3 required).

### Rubric and test run (challenge 4)

- `research/notes/rubric.md`: four criteria (grounded / cited / honest
  limits / right question), 0-2 each, hard gate — inventing anything caps
  the score at fail.
- `research/notes/test-questions.md`: 12 questions covering all six
  required types, each answered through the skill and scored: 12/12 pass
  (8/8).
- Every answer's claims were verified against live queries
  (`code/run_test_queries.py` runs the exact queries behind each answer).
- Honest caveat recorded in the file: answers were produced alongside the
  skill that governs them — the sheet must be re-run cold through the live
  agent in the demo; any failure goes to improvement-log.md (challenge 5).

### Progressive skill written (challenge 3)

- `SKILL.md` (project root): short entry point — what the database is, when
  to use it, the citation rule (`[id]` + source), the no-answer rule, and
  hand-over to the second skill.
- Detail files, read only when needed:
  - `skills/tables.md` — every table and column, with the special rows
  - `skills/queries.md` — copy-paste SQL for the usual questions
  - `skills/conventions.md` — rules for dates (negative BCE, no year 0) and
    names (collisions, title vs name), plus the counting rules
- Second skill: `skills/adding-data.md` — the add-new-material skill
  SKILL.md hands over to; encodes the repeatable steps (new seed file,
  rebuild, checks, re-export, journal entry).
- Verified with `code/test_skill.py`: all referenced files exist; all
  documented queries run against the rebuilt database unmodified.

### Spot-check done (challenge 2)

- Sampled 20 random rows (seed 20260929, reproducible) →
  `research/notes/spot-check-20-sample.csv`; audited each against the cited
  standard histories. **20/20 passed.**
- The full-database sweep (`code/checks.py`, all 359 rows) is what found the
  real errors: 9 data errors (2 wrong death years — 杨侗 621→619, 图帖睦尔
  1329→1332; 3 two-reign rows whose years didn't cover the restoration —
  李显， 李旦， 朱祁镇； 4 wrong predecessor links through the 690-712 and
  1457-1464 handovers — 武曌， 李重茂， 李隆基， 朱见深) and 2 check-rule
  fixes (predecessor adjacency rewritten for two-reign rows; documented
  exceptions whitelisted).
- All fixes applied in seeds, rebuilt (still 359 rows), CSVs regenerated
  (simplified + traditional). Checks now clean.
- Full log: `research/notes/spot-check-20-log.md`.
- Demo point earned the hard way: the random sample caught nothing; the
  systematic checks caught everything.

### Error found and fixed: UTF-8 mangled by shell round-trip

- **The error:** editing `seed_12` and `seed_13` with PowerShell
  `Get-Content -Raw` / `Set-Content` read the UTF-8 files in the ANSI
  codepage and wrote the mojibake back as UTF-8 — every Chinese character in
  both files was corrupted (e.g. 赵匡胤 → èµµåŒ¡èƒ¤).
- **How it was caught:** the verify script's Chinese-string queries returned
  nothing, and row 204 printed garbage in the console.
- **The fix:** both seed files rewritten from scratch with the editor tool;
  rebuilt and re-verified. A dedicated `code/check_encoding.py` now scans
  every text column for mojibake patterns — result: 0 bad cells.
- **Rule going forward:** never round-trip UTF-8 files through shell string
  operations on this machine; edit UTF-8 files only in the editor, or use
  `Get-Content -Encoding UTF8` if a script must read them.

### Zhu Wen predecessor link

- Zhu Wen (id 141, Later Liang) had predecessor_id NULL; set to 139 (Li Zhu,
  last Tang) per design rule 4 — the Tang→Later Liang abdication link now
  resolves: "who followed Li Zhu" → 朱温, Later Liang.

### Database completed (first full pass)

- Seeds 4-13 written: Xin (Wang Mang) → Eastern Han (with Gengshi, the
  Marquess of Beixiang and Shaodi Liu Bian as flagged claimants) → Three
  Kingdoms → both Jins → Northern dynasties (incl. child-emperor Yuan Zhao and
  the two rival puppets of 531-32) → Southern dynasties → Sui (incl. rival
  claimant Yang Tong) → Tang (two-reign rows for Zhongzong and Ruizong) → Wu
  Zhou (Wu Zetian) → Five Dynasties → Ten Kingdoms (kings flagged) → Liao,
  Song, Xi Xia, Jin → Yuan (incl. the erased Tianshundi) → Ming (two-reign
  Yingzong row) → Qing (Nurhaci included from Later Jin founding, per rule 3).
- Seed 14: era names — complete for Ming/Qing, iconic selections for Han,
  Tang, Song.
- Final counts: **44 dynasties, 280 rulers, 35 era names = 359 rows**.
- `PRAGMA foreign_key_check` clean. 21 cross-dynasty predecessor links are
  intentional (the abdication-coup chain, e.g. Cao Pi → Han Xiandi); design
  doc rule 4 rewritten to state this.
- Known name-collision traps recorded in notes: three Liu Yu (刘裕/刘彧/刘昱),
  two Sima Yan (司马炎/司马衍), two Zhao Xu (赵顼/赵煦), Li Heng twice
  (李亨/李恒), Xuanzong 玄宗/宣宗, Huizong 宋徽宗/元惠宗.
- Several posthumous-name fields carry explicit "(to verify)" flags — these
  are the material for the 20-row spot-check (challenge 2) before the demo.
- Next: spot-check 20 random rows against ctext.org originals; write the
  progressive skill, rubric and test questions (challenges 3-4).

### Setup (earlier today)

- Copied `templates/project_template` to `projects/chinese_emperors/`.
- Wrote design doc: scope 221 BCE–1912 CE, counting rules (who is a ruler,
  who is excluded), date convention (negative = BCE, no year 0).
- Wrote `code/schema.sql`: 3 tables (`dynasties`, `rulers`, `era_names`),
  3 foreign keys (`rulers.dynasty_id`, self-referencing
  `rulers.predecessor_id`, `era_names.ruler_id`), indexes on all FK columns.
- Seed batch 1: 44 dynasties/states with years, capitals, sources, notes.
- Seed batch 2: Qin — Ying Zheng, Huhai, Ziying (Ziying kept but flagged as
  king, not huangdi).
- Seed batch 3: Western Han (16 ruler rows incl. deposed Liu He and
  never-emperor Ruzi Ying) + Wudi's first 3 era names as the worked example
  of the third table.
- Built `code/build_db.py`: rebuilds `artifacts/chinese_emperors.db` fresh
  with `PRAGMA foreign_keys = ON`; adding material = new seed file + rerun.
- Fixed two build errors: duplicate dynasty name `Wu` (Three Kingdoms vs
  Ten Kingdoms state) → renamed the latter `Yang Wu`; console encoding
  (cp1252) → stdout forced to UTF-8 in build script.
- Verified: `PRAGMA foreign_key_check` clean; 44 dynasties, 16 rulers,
  3 era names.
- Next: Eastern Han onward, one seed file per dynasty, then spot-check
  20 rows (challenge 2), then progressive skill + rubric (challenges 3-4).
