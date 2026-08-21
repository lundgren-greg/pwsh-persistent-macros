---
name: simplify
description: >
  Reduce complexity without changing behavior. Use when code is messy, a
  function grew too many branches, the user wants a cleanup, or runs /simplify.
---

# Simplify

Preserve behavior. Delete complexity; do not relocate it.

## Process

1. Identify the behavior that must stay (tests, CLI contract, existing callers).
2. Find the expensive parts: nested conditionals, duplicate helpers, pass-through wrappers, flags that encode a missing model.
3. Prefer, in order:
   - delete the branch / layer / flag
   - reuse the helper that already exists
   - extract one named function that makes the main path linear
4. Run the existing tests or the original repro. If none exist, say what you verified by hand.

## Do not

- Rename widely for taste.
- Add a framework, DI container, or new abstraction layer as a "cleanup."
- Mix simplification with feature work in the same change unless the user asked for both.
