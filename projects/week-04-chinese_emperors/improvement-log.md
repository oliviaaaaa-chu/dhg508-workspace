# Improvement log

Each entry: what triggered it, what was wrong, what changed, and the answer
after. Entries come from real failures — the wrong answer, the failed
build, the empty query — recorded when they were fixed, not invented for
the grade. Rubric standard: `research/notes/rubric.md`.

---

## Entry 1 — the database silently stored garbage Chinese

- **Trigger:** test query 「万历皇帝用过哪些年号？」→ returned `None`.
- **What was wrong:** two seed files had been edited through a shell
  round-trip that read UTF-8 as ANSI; every Chinese character in them was
  mojibake (赵匡胤 stored as `èµµåŒ¡èƒ¤`). Queries that filtered on
  Chinese text silently matched nothing — the worst kind of error, no
  error message, just wrong answers.
- **What changed:** both seed files rewritten in the editor; added
  `code/check_encoding.py`, which scans every text column of every table
  for mojibake patterns and is now part of the routine after any rebuild.
- **After:** `check_encoding.py` reports **0 bad cells**; the same query
  now returns `万历, 1573-1620 [21: Mingshi 明史, annals juan 20-22]`.
  Rule recorded in the journal: never round-trip UTF-8 files through shell
  string operations on this machine.

## Entry 2 — 「谁继位了李柷？」answered "nobody"

- **Trigger:** demo-style question "who followed the last Tang emperor?"
  → empty result.
- **What was wrong:** Zhu Wen (Later Liang founder, id 141) had
  `predecessor_id` NULL — the Tang→Later Liang handover, the model
  abdication coup, was missing from the succession chain.
- **What changed:** predecessor link set to id 139 (Li Zhu) in
  `code/seed_10_five_dynasties.sql`, with the cross-dynasty rule noted in
  the design doc (rule 4) and the row's note.
- **After:** the same question returns 朱温, Later Liang
  `[141: Jiu Wudai shi 旧五代史, annals juan 1-2]`; the full abdication
  chain (Han → Wei → Jin → … → Sui → Tang → Later Liang → … → Song) now
  walks end to end — 23 cross-dynasty links, by design.

## Entry 3 — 杨侗 reigned "three years too long"

- **Trigger:** challenge-2 sweep (`code/checks.py`) flagged
  `rulers id=118: 618..621 vs 隋 581..618`.
- **What was wrong:** Yang Tong's death year was 621; in fact he was killed
  when Wang Shichong usurped, in 619. The row also leaked the error into
  the "reign outside dynasty" check.
- **What changed:** `year_end` 621 → 619 in `code/seed_09_sui_tang.sql`,
  note rewritten to state the 619 sequence; the row keeps a record of the
  earlier wrong value so the fix is auditable.
- **After:** the same sweep passes him as a documented exception (loyalist
  Sui at Luoyang to 619); re-running the check ends "all consistency
  checks clean".

## Entry 4 — restored emperors broke the succession chain twice

- **Trigger:** era check: 天顺 1457–1464 pointed at a ruler row ending
  1449; predecessor checks flagged 武曌, 李重茂, 李隆基, 朱见深.
- **What was wrong:** two related slips. (a) Rows for two-reign emperors
  (李显 684+705-710, 李旦 684-690+710-712, 朱祁镇 1435-1449+1457-1464,
  图帖睦尔 1328-1329+1329-1332) stored only the first reign's end, so
  facts from the second reign sat outside the row's own years. (b) The
  predecessor chain went by temple-name adjacency instead of the actual
  sequence of 690-712 and 1457-1464 — Wu Zetian's predecessor was listed
  as Gaozong instead of Ruizong, Chenghua's as Daizong instead of his
  father.
- **What changed:** the four rows now span both reigns with notes
  explaining each interruption; the 690/710/712/1457 handover links were
  rebuilt; `code/checks.py`'s adjacency rule was rewritten for the
  two-reign case (successor's start must fall inside the predecessor's
  span ±2) — the checker itself was wrong first, the data second.
- **After:** 「天顺是谁的年号」→ 朱祁镇
  `[15 + 258: Mingshi 明史, annals juan 12-13]`;
  「武则天从谁手里拿的皇位」→ 李旦
  `[123: Xin Tangshu 新唐书, annals juan 5]`; checks clean.

## Entry 5 — two states, one name: the database refused to exist

- **Trigger:** first `build_db.py` run: `UNIQUE constraint failed:
  dynasties.name`.
- **What was wrong:** two different states were both named "Wu" — Sun
  Quan's 吳 (Three Kingdoms) and Yang Xingmi's 楊吳 (Ten Kingdoms). The
  schema's uniqueness guard did its job, but the data design hadn't
  thought about it.
- **What changed:** the Ten Kingdoms state renamed **Yang Wu** (after
  founder Yang Xingmi) in `code/seed_01_dynasties.sql`.
- **After:** build clean, 44 distinct states; the two Wu states are now
  distinguishable by name *and* by era (229 vs 902) — and the incident is
  the reason `code/checks.py` exists as a repeatable gate.

## Entry 6 — the live test answered from general knowledge

- **Trigger:** the user ran the skill cold and got answers built from the
  model's own historical knowledge — fluent, plausible, and not one row of
  the database in them. Exactly the rubric's automatic-fail case (invented
  = ungrounded), and exactly what `SKILL.md` was written to prevent — but
  the prohibition lived in one line among several, easy to slide past.
- **What was wrong:** `SKILL.md` said "answer only from the rows" but did
  not say the more important negative: **the model's general knowledge of
  Chinese history is not a data source and must not appear**. An agent told
  what to do but not what *not to do* will do the impressive thing, not the
  grounded thing.
- **What changed:** the rubric is now embedded in `SKILL.md` as enforced
  rules 0-4 (it was only referenced before): the hard gate comes first
  (one invented fact = the whole answer fails); rule 1 states the negative
  explicitly ("general knowledge is exactly what must NOT appear; no row,
  no sentence"); rule 2 treats an uncited fact as an invented fact; the
  self-check line at the bottom ("could a reader strike every sentence and
  find its row?") turns the rubric into a pre-answer gate, not a post-hoc
  grade.
- **After (re-test, cold):** asked 「武則天是中國歷史上唯一的女皇帝嗎？」—
  general knowledge would answer "yes, the only female emperor in Chinese
  history" (unfalsifiable from the data, unscoped, uncited). The grounded
  answer now is: 武曌 is the only female sovereign **in this database's
  range, 221 BCE-1912**, under her own state 武周, 690-705
  `[140: Xin Tangshu 新唐書, annals juan 4]` — and the data can only speak
  for its range. Difference: scoped, sourced, and honest about limits.
- **Rule going forward:** any edit to `SKILL.md` keeps the rubric embedded
  in the rules section — the reference file is not enough.

---

## Pattern across entries

Three of five errors were invisible at insert time and only surfaced
through a question or a check. The repeatable defence is the routine in
`skills/adding-data.md`: build → `checks.py` → `check_encoding.py` →
re-export → journal entry. Every future entry in this file should start
with a trigger from that routine.
