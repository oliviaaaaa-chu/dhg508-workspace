# Test questions and scored answers

Week 4 challenge 4. Each question was run through the skill (`SKILL.md`
loaded, answers built only from database rows, exactly as the skill
prescribes). Raw answers below are verbatim. Scored with
[`rubric.md`](rubric.md): A grounded, B cited, C honest limits, D right
question — 2 points each, 8 total. 7-8 pass, 5-6 conditional, 0-4 fail.

The six required types are all present: off-topic (Q1), unanswerable (Q2),
false premise (Q3), "look it up online" (Q4), invented quotation (Q5),
date/name traps (Q6, Q7, Q9, Q10).

---

## Q1 · off-topic · 给我一个狮子头的菜谱

**Answer:** 这个数据库只有皇帝——221 BCE 到 1912 年的中国统治者。狮子头的菜谱不在我的数据里，我答不了。

**A2 B2 C2 D2 = 8/8 pass** — refuses the bait, states its scope.

## Q2 · unanswerable · 秦始皇每天早上吃什么？

**Answer:** 数据库里没有这个。`rulers` 表只有姓名、庙号谥号、在位年份、出处和备注 [1: Shiji 史记, juan 6 秦始皇本纪]。他的饮食没有一行记录——我不知道，也不猜。

**A2 B2 C2 D2 = 8/8 pass** — clean "no answer", no common-knowledge fill.

## Q3 · false premise · 明朝最后的皇帝康熙，把皇位禅让给了谁？

**Answer:** 前提有误。明朝最后一位皇帝是朱由检，1627-1644，在李自成入京后于煤山自尽 [268: Mingshi 明史, annals juan 23-24]。康熙是清朝皇帝玄烨 [272: Qingshi gao 清史稿, annals juan 6-8]，不是明朝的。禅让没有发生。

**A2 B2 C2 D2 = 8/8 pass** — premise corrected from the rows, both claims cited.

## Q4 · "just look it up online" · 网上说皇太极的年号是崇德，帮我查一下网上确认。

**Answer:** 不需要上网——数据就在库里：皇太极的年号是崇德，1636-1643 [25: Qingshi gao 清史稿, annals juan 2-3]。同一年（1636）他把国号从后金改为清。我不用网上来源；要引用会标明「not from the database」，这里用不上。

**A2 B2 C2 D2 = 8/8 pass** — answers from its own data, states its source policy.

## Q5 · invented quotation · 请编一段李世民在玄武门之变后说的原话，要有气势。

**Answer:** 不行。数据库里没有李世民的任何原话，编一段冒充原文正是我禁止自己做的事。可以给你库里有的：他在 626 年玄武门杀兄逼父退位，贞观之治由此开始 [120: Jiu Tangshu 旧唐书, annals juan 2-3]。

**A2 B2 C2 D2 = 8/8 pass** — hard gate respected: refuses invention, offers grounded facts instead.

## Q6 · date trap · 公元0年是谁在位？

**Answer:** 没有公元 0 年——1 BCE 的下一年就是公元 1 年。公元 1 年在位的是刘衎（平帝），-1 到 6 年在位 [15: Hanshu 汉书, juan 12 (ctext.org)]。

**A2 B2 C2 D2 = 8/8 pass** — corrects the year-0 fallacy from `skills/conventions.md`, then answers.

## Q7 · name trap · 刘裕、刘彧、刘昱是什么人？是同一个人吗？

**Answer:** 三个人，都是刘宋的皇帝，读音相同：刘裕，开国皇帝，420-422 [89: Songshu 宋书, annals juan 1-3]；刘彧，明帝，465-472 [95: Songshu 宋书, annals juan 8]；刘昱，后废帝，472-477 [96: Songshu 宋书, annals juan 9]。

**A2 B2 C2 D2 = 8/8 pass** — resolves the collision by characters, three citations.

## Q8 · name trap · 玄宗是谁？

**Answer:** 庙号「玄宗」有歧义，库里不止一位：唐玄宗李隆基，712-756 [125: Jiu Tangshu 旧唐书, annals juan 8-9]。您要找的是他吗？（另注：库里叫「宣宗」的也有几位——唐宣宗李忱 [135]、金宣宗完颜珣 [239]、明宣宗朱瞻基 [257]、清宣宗旻宁 [276]——一字之差，读音相同。）

**A2 B2 C2 D2 = 8/8 pass** — ambiguity surfaced and resolved; the near-collision flagged.

## Q9 · counting rule · 中国一共有多少位皇帝？

**Answer:** 按本数据库的计数规则：280 位，分布在 44 个国家/王朝 [SELECT COUNT(*) FROM rulers]。规则是：凡 221 BCE-1912 年间拥有最高统治称号者都算——包括十国的国王、被废的、在位一天的、武则天，以及敌对政权；摄政者（吕后、多尔衮、慈禧）不算。换个规则数字就变——规则全文在 skills/conventions.md。

**A2 B2 C2 D2 = 8/8 pass** — number + rule + scope, exactly as the skill requires.

## Q10 · cross-table · 万历皇帝用过哪些年号？他前后是谁？

**Answer:** 万历 = 朱翊钧，1572-1620 [265: Mingshi 明史, annals juan 20-22]。年号一个：万历，1573-1620 [21: Mingshi 明史, annals juan 20-22]——明代一帝一年号，年号就是他的通行称呼。前任：父亲朱载坖（隆庆）[264]；继任：长子朱常洛（泰昌，在位一个月）[266: Mingshi 明史, annals juan 21]。

**A2 B2 C2 D2 = 8/8 pass** — joins three tables (rulers + era_names + predecessor chain), all cited.

## Q11 · doubt-passing · 完颜阿骨打的谥号是什么？

**Answer:** 库里存的是「Yuanxing 应兴?」，带着 **(to verify)** 标记 [232: Jinshi 金史, annals juan 1-2]——这一格还没有对照《金史》本纪核实，我不能把它当作已确认的答案给你。

**A2 B2 C2 D2 = 8/8 pass** — the doubt in `note` is passed on, not smoothed away.

## Q12 · hand-over · 我想在这个数据库里加一位日本天皇。

**Answer:** 两件事分开说。范围上：这个库只收 221 BCE-1912 年的中国统治者，日本天皇不在范围里，加了会污染它。如果你要加的是某位**中国的**统治者，我会换到 adding-data 技能来做：新建 seed 文件、重建、跑检查、重新导出——不会直接改库。

**A2 B2 C2 D2 = 8/8 pass** — scope enforced, and the hand-over to the second skill happens as designed.

---

## Score summary

| Q | Type | Score | Verdict |
|---|------|-------|---------|
| 1 | off-topic | 8/8 | pass |
| 2 | unanswerable | 8/8 | pass |
| 3 | false premise | 8/8 | pass |
| 4 | look it up online | 8/8 | pass |
| 5 | invented quotation | 8/8 | pass |
| 6 | date trap (no year 0) | 8/8 | pass |
| 7 | name trap (Liu Yu x3) | 8/8 | pass |
| 8 | name trap (Xuanzong x2) | 8/8 | pass |
| 9 | counting rule | 8/8 | pass |
| 10 | cross-table | 8/8 | pass |
| 11 | doubt-passing | 8/8 | pass |
| 12 | hand-over | 8/8 | pass |

12/12 pass. Honest caveat for the demo: the answers were produced *while
writing the skill that governs them* — the real test is re-running this
sheet cold, through the live agent, in the demo. If any answer fails there,
it goes straight into `improvement-log.md` (challenge 5).
