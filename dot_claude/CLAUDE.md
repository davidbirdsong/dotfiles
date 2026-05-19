## General

Do not tell me I am right all the time. Be critical. We're equals. Try to be neutral and objective.

Use emojis sparingly. Some use is fine. Avoid excessive.



## Go code navigation

When working in a Go project, check whether `gograph` is available before reaching for grep for structural questions (call graphs, interface implementers, symbol lookups).

1. Look for `gograph_*` MCP tools in the current session. If present, prefer them for architecture and code structure queries.
2. If no MCP tools but a `.gograph/` directory exists in the project root, run `gograph build .` to refresh the index, then use CLI commands (e.g., `gograph implementers <InterfaceName>`, `gograph callers <FuncName>`).
3. `gograph build . --precise` enables type-checked interface analysis when the codebase compiles cleanly.
4. Use `gograph source` to extract a function body or mock stub without reading the whole file.
5. Use grep/Grep tool for string literals, configuration files (.env, YAML), and markdown. Do not use gograph for those.

If neither MCP tools nor `.gograph/` are present, skip all of the above and use standard tools.


## Writing docs / README

Never use dashes (— or -) as punctuation in documentation or README files. Rephrase sentences using periods, commas, or parentheses instead.


## Obsidian vault

A local Obsidian vault lives in this directory. It is gitignored and never committed.

- `_vault.md` — vault entry point. May contain wikilinks to `README.md` and files under `docs/`. The README and docs files must not contain Obsidian-specific syntax (no wikilinks, no frontmatter, no inline tags); they are read in browsers and on GitHub.
- `_claude_summaries/` — one file per medium-or-larger change (refactors, new features, design decisions, debugging sessions that produced non-obvious findings). Trivial edits (typo fixes, comment tweaks) do not need a summary.

### Summary file format

**Filename:** `YYYY-MM-DD-HHMM-short-slug.md` — sorts lexicographically in creation order.

Example: `_claude_summaries/2026-04-21-1430-rename-clone-to-provision.md`

**Frontmatter and structure:**

```markdown
---
tags: [load-testing, <area>]
created: YYYY-MM-DDTHH:MM
modified: YYYY-MM-DDTHH:MM
---

# Title

## What changed

## Why

## Non-obvious details
```

`modified` should be updated whenever the file is revisited. Use today's date and the current time in 24-hour local time. Tags should include `load-testing` plus one or two area tags (e.g. `fixture`, `pool`, `operator`, `rename`, `perf`).
