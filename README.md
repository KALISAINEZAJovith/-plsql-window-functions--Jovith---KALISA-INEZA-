# KigaliMart — Window Functions (concepts & guidance)

NAME: KALISA INEZA Jovith
ID: 26259
Course: Database Development with PL/SQL (INSY 8311)  
Instructor: Eric Maniraguha  

## Purpose

This document explains the key analytical concepts used in the assignment and how they behave in MySQL (8.0+). It focuses on plain-language definitions, behaviour notes and practical tips — no runnable SQL is included here.

## Business context (brief)

KigaliMart needs faster, reliable analytics to improve inventory and marketing decisions across regions. The assignment demonstrates using window functions to obtain rankings, running totals, period-over-period comparisons, quantiles and rolling averages.

## Success criteria (high level)

- Identify top products per region/quarter (ranking functions)
- Compute cumulative monthly sales (aggregate windows)
- Measure month-over-month growth (offset functions)
- Segment customers into quartiles (NTILE)
- Calculate 3‑month moving averages (frame-based AVG)

## Key terms and how they work

### Window functions — overview

Definition: perform row-level calculations using a "window" (a set of rows related to the current row) without collapsing result rows.

Anatomy: function + OVER() clause; optionally PARTITION BY and ORDER BY inside OVER().

Result: computed per row; number of rows returned unchanged.

### Partitioning and ordering

- PARTITION BY splits data into independent groups where calculations restart.
- ORDER BY inside OVER controls sequences for running totals and offset functions.
- Tip: choose deterministic ORDER BY columns to avoid ambiguous results.

### Frame clauses (ROWS / RANGE)

- Purpose: limit rows considered relative to the current row (e.g., last 2 rows).
- ROWS is row-count based; RANGE is value-based and can behave differently when ties exist.
- Typical use: ROWS BETWEEN 2 PRECEDING AND CURRENT ROW for 3-period moving averages.

### Ranking functions

- ROW_NUMBER(): unique sequence per partition (no ties).
- RANK(): same rank for ties; leaves gaps afterwards.
- DENSE_RANK(): same rank for ties; no gaps.
- Use-case: top‑N per group — pick ranking function based on tie behavior you want.

### Aggregate window functions

- SUM(...) OVER, AVG(...) OVER compute aggregates across the window but keep rows intact.
- Implementation tip: when aggregating buckets (e.g., monthly sums), do the bucket aggregation first in a derived table, then apply window aggregates.

### Offset functions (LAG / LEAD)

- LAG provides values from previous rows; LEAD from subsequent rows.
- Useful for period‑over‑period comparisons (e.g., month-over-month).
- First row in partition yields NULL for LAG — combine with NULLIF or conditional logic for safe math.

### NTILE (quantiles)

- NTILE(n) divides ordered rows into n buckets; NTILE(4) commonly used for quartiles.
- When the row count is not divisible by n, some buckets will differ by one row.

### Date formatting and parsing

- DATE_FORMAT converts dates to strings for grouping/display (e.g., year-month).
- STR_TO_DATE parses strings into DATE/DATETIME values.
- Store dates in DATE/DATETIME types where possible; format only for presentation or grouping.

### NULLIF and defensive calculations

- NULLIF(x,0) prevents divide-by-zero in percentage calculations by returning NULL when denominator is 0.
- Pattern: growth = (current - previous) / NULLIF(previous, 0)

## Common troubleshooting notes

- "#1305 TO_CHAR/TO_DATE does not exist": SQL originally written for Oracle; convert formatting/parsing functions to MySQL equivalents or use native date literals.
- Window functions missing: requires MySQL 8.0+. Verify server version if functions fail.
- Unexpected ranking gaps: choose DENSE_RANK vs RANK depending on whether gaps are acceptable.

## Final notes

This README is intentionally code-free and focused on conceptual clarity. If you want a short one-page cheat-sheet or a version with small code snippets for each concept, I can produce that as a separate file.

---

If you want a final visual polish (PDF export, improved typography, or a printable cheat-sheet), tell me which format and I'll prepare it.
