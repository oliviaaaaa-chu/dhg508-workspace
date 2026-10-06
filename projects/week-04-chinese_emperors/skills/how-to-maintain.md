# How to maintain it — adding new material

Handed over from `SKILL.md` when the user wants to extend the database
rather than query it.

## The one rule

**Never edit an old seed file and never INSERT into the live database.**
The database is always rebuilt from the seeds, so an edit by hand dies on
the next rebuild — and an edit to an old seed breaks the provenance of
every row in it.

## The repeatable steps (also in research/design/design_doc.md, Methodology)

1. **New batch, new file.** Write `code/seed_NN_<topic>.sql`, numbered after
   the last one. One batch = one file = one date range or one table.
   Filenames sort before contents load, so keep the numbers zero-padded.
2. **Every row gets `source` (document + juan) and `note` for anything
   uncertain.** A row without a source is a bug; add it as "to verify" and
   flag the doubt in `note`.
3. **Keep the original wording beside the normalisation** (original
   characters in the `*_cn` columns; romanisation is the normalisation, not
   the record).
4. **Rebuild:** `python code/build_db.py` — recreates
   `artifacts/chinese_emperors.db` from scratch, foreign keys ON, and runs
   `PRAGMA foreign_key_check`.
5. **Re-check:** `python code/checks.py` — must end "all consistency checks
   clean". New documented exceptions go into the whitelists in that file,
   each with a reason.
6. **Re-export:** `python code/export_csv.py` then
   `python code/export_csv_traditional.py` (regenerates simplified +
   traditional CSVs in `artifacts/`). The traditional exports are what
   `SKILL.md` answers from — this step is not optional, a stale CSV means
   the skill answers from outdated data.
7. **Log it:** one entry in `research/journal/research_journal.md` — what was
   added, why, and anything the checks said.
8. **Verify against the originals:** pick rows from the new batch and compare
   with the cited juans before calling them done; log the comparison as in
   `research/notes/spot-check-20-log.md`.

## Watch out for

- id collisions: rulers ids run 1-280; new ruler rows continue from the
  highest existing id (`SELECT MAX(id) FROM rulers`).
- Cross-dynasty predecessor links are a feature, not a bug — 23 exist by
  design; the checks whitelist them deliberately.
- Two-reign rulers: one row spanning both reigns, note explains the gap.
- Name collisions (Liu Yu x3, Zhao Xu x2…): resolve with the characters in
  `personal_name_cn`, never by romanisation alone (full list:
  `skills/principles.md`).
