---
name: tdd
description: >
  Implement behavior with red-green-refactor: failing test first, then the
  smallest code that passes, then cleanup. Use when adding a feature with
  tests, writing unit tests first, or the user runs /tdd.
---

# Test-driven development

## Cycle

1. **Red.** Write one test that describes the next behavior. Run it. Confirm it fails for the right reason (not compile noise or a bad assertion).
2. **Green.** Write the smallest production change that makes that test pass. No extra features.
3. **Refactor.** Clean names and duplication only while tests stay green.
4. Repeat for the next behavior.

## Rules

- If you already wrote production code, do not invent a test that only mirrors it. Delete or isolate that code and start from a failing test, or say you are covering after the fact (not TDD).
- Tests must be able to fail. A test that cannot fail is not a test.
- Use the repo's real runner (xUnit, Pester, pytest, cargo test, npm test). Do not invent a parallel harness.
- Tests create temp files/dirs and clean them up in `finally` (or the language equivalent).
- Stop and ask if the behavior itself is still unclear. Do not TDD a guess.
