---
name: model-settings-switcher
description: Update oh-my-openagent model + fallback model settings based on what subscriptions you have (OpenAI-only, GitHub Copilot, OpenCode, etc). Asks which subscriptions are available, then rewrites the config and validates it.
license: MIT
compatibility: opencode
metadata:
  audience: maintainers
  category: config
---

# Model Settings Switcher (Oh-My-OpenAgent / Oh-My-OpenCode)

Use this skill when you want to **change which models OpenCode uses** (primary + fallback) depending on which provider subscriptions you currently have.

## Files this skill manages

- `opencode/.config/opencode/oh-my-openagent.json`

## Inputs I must collect (ask the user)

1. Which subscriptions/providers are available right now?
   - OpenAI API (paid)
   - GitHub Copilot
   - OpenCode (free models only)
   - Other (if so: which provider prefix is configured, e.g. `openrouter/`, `anthropic/`, etc.)
2. Preference for **cost vs quality** for defaults:
   - Balanced (default)
   - Cheapest
   - Best quality

## Output contract

I will:

1. Update `opencode/.config/opencode/oh-my-openagent.json` so that:
   - Every agent and category has a usable `model`.
   - `fallback_models` only include providers the user says they can access.
   - If the user says “OpenAI only”, then no `github-copilot/*` models remain.
2. Keep variants consistent (`low|medium|high|xhigh|max`) where they already exist.
3. Validate JSON after edits (`jq . <file>`) and stop if invalid.
4. Report a short summary of what changed.

## Provider presets

### A) OpenAI-only (primary) + OpenCode free fallbacks

Use when the user only has an OpenAI subscription.

- Primary models (OpenAI):
  - Heavy/reasoning: `openai/gpt-5.4` (variants: `high` or `xhigh`)
  - General/default: `openai/gpt-5.4` (`medium`)
  - Fast/cheap: `openai/gpt-5.4-mini`
  - Smallest: `openai/gpt-5-nano`

- Fallback models (OpenCode free list; keep order):
  1. `opencode/gpt-5-nano`
  2. `opencode/gemini-3-flash`
  3. `opencode/glm-5`
  4. `opencode/minimax-m2.7`
  5. `opencode/big-pickle`

### B) OpenAI + GitHub Copilot (hybrid)

Use when the user has both. Prefer OpenAI as primary unless the user asks otherwise.

- Keep the same OpenAI primaries as (A).
- Add Copilot fallbacks ahead of OpenCode free fallbacks for comparable tiers.

### C) Copilot-only

Use when the user has only GitHub Copilot.

- Set primaries to `github-copilot/*` equivalents (matching the existing config’s intent).
- Remove `openai/*` models.
- Keep OpenCode free models as last-resort fallbacks.

## Procedure

1. Ask the user the two input questions (providers + cost/quality preference).
2. Read `opencode/.config/opencode/oh-my-openagent.json`.
3. Apply the correct preset:
   - If OpenAI-only → use preset (A).
   - If OpenAI + Copilot → use preset (B).
   - If Copilot-only → use preset (C).
   - If “Other” providers are mentioned, only include them if the user provides the exact provider prefix and at least one model name.
4. Normalize:
   - Ensure every `fallback_models` is an array of objects like `{ "model": "...", "variant": "..."? }`.
   - Remove any fallback entries for unavailable providers.
5. Validate:
   - Run `jq . opencode/.config/opencode/oh-my-openagent.json`.
6. Summarize changes (2-6 bullets max): which providers are now used, and what the new primary model is for the major agents (`sisyphus`, `hephaestus`, `oracle`).

## Example prompts (should trigger)

- “Switch my OpenCode config to OpenAI models only, and use free fallbacks.”
- “I have Copilot again—update the model fallbacks accordingly.”
- “Change the default models; I only have OpenAI right now.”

## Near-misses (should NOT trigger)

- “Which OpenAI model is best for coding?” (no request to change config)
- “Explain what fallback models are.” (no request to modify settings)
