# Principles — the few rules that always hold

Read this before answering any question about dates or names, and before
scoring or being scored.

## The rubric, enforced (scoring standard: research/notes/rubric.md)

**0. The hard gate.** One invented fact = the whole answer fails, no matter
how good the rest is. If a sentence cannot be traced to a row by id, either
delete it or mark it 「not from the database」.

**1. Grounded (A).** The model already "knows" Chinese history — that
knowledge is exactly what must NOT appear. General knowledge is not a data
source. Every sentence must have a row behind it, found in the three CSV
exports, in this session. No row, no sentence.

**2. Cited (B).** Every factual claim carries `[id]` and the row's
`source`. Example: 「…[265: Mingshi 明史, annals juan 20-22]」. An
uncited fact is treated as an invented fact.

**3. Honest limits (C).** If the data has no answer, say 「the data has no
answer」 — do not fill in with common knowledge. Anything from outside the
files must be flagged 「not from the database」. Where a row doubts itself
("to verify", disputed dates), pass the doubt on as-is; do not smooth it.

**4. Right question (D).** Resolve ambiguity before answering (which 劉裕？
which 玄宗？) — say which candidates the data holds. Correct false premises
from the rows. Refuse off-topic requests and requests to invent quotations.
When asked "how many", state the counting rule before the number.

## Character set

The skill answers from the traditional-Chinese CSV exports — all Chinese in
answers is Traditional (萬曆, 劉裕, 趙匡胤). The simplified forms exist only
in the other CSV export and the seeds.

## Dates

- Years are integers, **negative = BCE**: `-221` is 221 BCE, `1912` is 1912 CE.
- **No year 0**: the row before `1` is `-1` (1 BCE). Never do naive
  arithmetic across the year 1 BCE / 1 CE boundary.
- Reign years are the years a ruler held power, not era years; a Western
  reign straddling our year 1 appears as e.g. `-1 .. 6` (平帝 Pingdi).
- Approximate or disputed dates keep the doubt in `note` — quote it, do not
  round it away.
- One row may span **two reigns** (restorations): 朱祁鎮 Zhu Qizhen
  1435-1449 + 1457-1464, 李顯 Li Xian and 李旦 Li Dan around 武則天 Wu
  Zetian, 圖帖睦爾 Tugh Temür. The `note` carries the interruption.
- Rival states overlap: in 1127 both Jin and Southern Song rulers reign.
  "Who was emperor in year X" can have several true answers — give them all,
  by state.

## Names

- Every name is stored twice: romanised (`personal_name`) and original
  characters (`personal_name_cn`, traditional). **The characters are the
  record**; the romanisation is the normalisation. When a user's
  romanisation is ambiguous, answer with the characters.
- **Name collisions (all different people):**
  - Liu Yu = 劉裕 (Liu Song founder, id 89), 劉彧 (Liu Song Mingdi, id 95),
    劉昱 (Liu Song Houfei, id 96)
  - Sima Yan = 司馬炎 (Jin Wudi, id 44), 司馬衍 (Eastern Jin Chengdi, id 50)
  - Zhao Xu = 趙頊 (Song Shenzong, id 209), 趙煦 (Song Zhezong, id 210)
  - Li Heng = 李亨 (Tang Suzong, id 126), 李恆 (Tang Muzong, id 131)
  - Xuanzong = 唐玄宗 (id 125) and 唐宣宗 (id 135); Huizong = 宋徽宗
    (id 211) and 元惠宗 (id 252)
- **Title vs name:** rulers are called by temple name (太宗 Taizong), by
  posthumous name (文皇帝 Wendi), or by reign name (萬曆 Wanli — Ming/Qing
  only). These do NOT match each other: 唐玄宗 = 李隆基 = 文皇帝. Resolve
  through the `rulers` row, never by pattern-matching titles.
- Same title, different dynasties: five states romanise as "Han" (漢,
  蜀漢, 後漢, 南漢, 北漢) and two as "Jin" (晉, 金). Answer by dynasty_id,
  and say which state you mean.

## Counting rules

- Included: every holder of supreme sovereign title in 221 BCE - 1912 CE,
  including kings (王) in Ten Kingdoms states, deposed and short-reign
  rulers, 武則天 Wu Zetian, child emperors, and rulers of rival states.
- Excluded: regents who never took the title (呂后 Lü Zhi, 多爾袞 Dorgon,
  慈禧 Cixi), khans before a state's imperial claim is documented in its row.
- Full rules: `research/design/design_doc.md`. State the rule when giving a
  count.
