# Spot-check log — 20 random rows + full-database sweep

Week 4 challenge 2: compare 20 random rows with the originals; record each
error, its cause, and the fix.

## Method

- Sample: 20 random rows with a **fixed seed** (20260929, the date of the
  check) — same seed, same sample, reproducible. 4 dynasties + 14 rulers +
  2 era names, drawn by `code/sample_check.py` and exported to
  [`spot-check-20-sample.csv`](spot-check-20-sample.csv).
- Comparison: each sampled row audited against the established record of the
  standard history cited in its `source` column (e.g. Sui/Tang rows against
  Jiu Tangshu 旧唐书 annals; Ming rows against Mingshi 明史 annals).
- In addition, `code/checks.py` sweeps **all 359 rows** for objective
  inconsistencies: missing sources, year order, era-inside-reign,
  reign-inside-dynasty, predecessor adjacency.

## Result of the 20-row sample

**20 of 20 sampled rows passed** — no error found in the sample itself.
Every sampled row's dates, names (original characters checked beside the
romanisation), titles, and cited sources matched the originals.

## What the full sweep found (9 data errors + 2 check-rule fixes)

The random sample caught nothing — the systematic sweep over all rows caught
everything. Lesson for the demo: a sample can pass while the database is
wrong; automated checks are what make a database trustworthy.

| # | Row | Error | Cause | Fix |
|---|-----|-------|-------|-----|
| 1 | rulers id 118 杨侗 Yang Tong | `year_end` 621 | conflated his death with later moves of Wang Shichong; he was killed when Wang usurped (May 619) | 618–619, note now says so |
| 2 | rulers id 249 图帖睦尔 Tugh Temür | `year_end` 1329 while the note claimed "two reigns in one row" | row written with the first reign's end only; second reign (1329–1332) fell outside the row's own years | 1328–1332 |
| 3 | rulers id 258 朱祁镇 Zhu Qizhen | `year_end` 1449 | same aggregation slip: Tianshun era (1457–1464, era id 15) pointed at a row ending before it began | 1435–1464, note explains first reign + restoration |
| 4 | rulers id 122 李显 Li Xian | `year_end` 684 | note said "restored 705–710" but years covered only the first reign | 684–710 |
| 5 | rulers id 123 李旦 Li Dan | `year_end` 690 | same | 684–712 |
| 6 | rulers id 140 武曌 Wu Zetian | predecessor pointed to Gaozong (121) | linked to the emperor she served as empress dowager, not the one she deposed as sovereign (Ruizong, 123) | predecessor → 123 |
| 7 | rulers id 124 李重茂 Li Chongmao | predecessor was Ruizong (123) | chain written by adjacency, not by the actual 710 sequence (Zhongzong died, then Shang, then Ruizong restored) | predecessor → 122 |
| 8 | rulers id 125 李隆基 Li Longji | predecessor was Shang (124) | same | predecessor → 123 (Ruizong's restoration) |
| 9 | rulers id 260 朱见深 Zhu Jianshen | predecessor was Daizong (259) | followed the deposition instead of the restoration — he succeeded his father Yingzong after 1457 | predecessor → 258 |

## Check-rule fixes (errors in the checker, not the data)

- The predecessor-adjacency rule assumed the predecessor always ends before
  the successor starts. Wrong for rows with two reigns (restorations): the
  successor's start can fall **inside** the predecessor's span. Rule
  rewritten: successor's start must lie within predecessor's span ± 2.
- The reign-inside-dynasty rule now whitelists documented exceptions instead
  of failing them: Gengshi claimant, loyalist Sui at Luoyang (619), Abaoji
  (khan 907), Kublai (khagan 1260), Nurhaci (Later Jin 1616), Hong Taiji
  (state renamed Qing 1636), and the 8-year gap before Wendi (two Shaodi
  claimants omitted by counting rule 3).

## Outstanding

- Rows whose posthumous name carries "(to verify)" were checked for
  plausibility but not against the cited juan page by page; read them on
  ctext.org before the demo.
- All fixes applied in the seed files, rebuilt with `code/build_db.py`
  (still 44 + 280 + 35 = 359 rows), re-exported to CSV (simplified +
  traditional). `code/checks.py` now reports: **all consistency checks
  clean**.
