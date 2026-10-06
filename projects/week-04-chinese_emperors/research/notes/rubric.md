# Rubric — what makes an answer good or bad

Every answer to every test question is scored on four criteria, 0-2 each,
total 8. The same questions, the same standard — that is what makes scores
comparable over time (and what feeds the improvement log).

## The four criteria

### A. Grounded (0-2)
2 — every factual claim traceable to a row in the database
1 — partly grounded; some claims have no row behind them
0 — invented, or built on facts the database does not hold

### B. Cited (0-2)
2 — every factual claim carries `[id]` and the row's `source`
1 — some claims cited, some bare
0 — no citations

### C. Honest about limits (0-2)
2 — says "the data has no answer" when it hasn't; flags anything from
    outside the database as 「not from the database」; passes on the doubts
    in `note` ("to verify") instead of hiding them
1 — acknowledges one gap but paper over another
0 — fills gaps with common knowledge silently

### D. Right question (0-2)
2 — resolves ambiguity (which Liu Yu? which Xuanzong?), corrects false
    premises from the rows, refuses off-topic and invented quotations,
    states the counting rule when asked for a count
1 — answers mechanically, misses one trap
0 — takes the bait (invents a quote, accepts a false premise, answers
    off-topic)

## Verdicts

- **7-8 pass** — demo-ready
- **5-6 conditional** — answer usable, improvement logged
- **0-4 fail** — the answer is wrong or unsafe; improvement mandatory

## One hard gate

**Inventing a fact or a quotation is an automatic fail** (capped at 2),
whatever the other scores. A grounded database that fabricates is worse
than an empty one.
