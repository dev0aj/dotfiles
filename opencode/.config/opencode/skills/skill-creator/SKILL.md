---
name: skill-creator
description: Create new agent skills (SKILL.md), improve existing skills, and help validate triggering. Use when the user asks to "turn this workflow into a skill", wants a reusable instruction pack, or needs help naming/scoping/writing/testing a skill. Not tied to any model provider.
license: MIT
compatibility: opencode
metadata:
  audience: maintainers
  category: meta
---

# Skill Creator

Help the user design, write, and iterate on OpenCode agent skills.

## What I do

- Interview the user to capture intent, inputs/outputs, edge cases, and success criteria.
- Draft or revise `SKILL.md` with correct frontmatter and clear, reusable instructions.
- Propose realistic test prompts to sanity-check that the skill is useful and triggers.
- Tighten the `description` field so the right skill gets selected at the right time.

## Constraints

- Provider-agnostic: do not assume any specific model vendor, CLI, or hosted environment.
- Keep the skill lean: prefer small, general instructions over brittle, overfit rules.
- Follow OpenCode skill rules:
  - One folder per skill under `.../skills/<name>/SKILL.md`.
  - YAML frontmatter must include `name` and `description`.
  - Only these frontmatter fields are recognized: `name`, `description`, `license`, `compatibility`, `metadata`.
  - `name` must match the directory name and the regex `^[a-z0-9]+(-[a-z0-9]+)*$`.

## Workflow

### 1) Capture intent (don't write yet)

Ask only what you need to remove ambiguity:

1. What outcome should this skill reliably produce?
2. When should it trigger? Provide 3-5 example user prompts that should trigger, and 2-3 near-misses that should not.
3. What inputs does it expect (files, commands, URLs, existing code paths)?
4. What outputs are required (files changed, report structure, command(s) to run, checklist)?
5. What are the top 3 failure modes to avoid?

If the user already described a workflow earlier in the conversation, extract it first and confirm it back to them.

### 2) Pick the smallest useful scope

Drive toward a single clear job. If the user asks for a "do everything" skill, propose splitting by:

- Audience (maintainers vs contributors)
- Domain (deploy vs release vs triage)
- Artifact (report generator vs refactor helper)

### 3) Write or edit `SKILL.md`

Write imperative instructions with enough reasoning to generalize.

Use this structure (adapt as needed):

```markdown
---
name: <skill-name>
description: <when to trigger + what it does in 1-3 sentences>
license: <optional>
compatibility: opencode
metadata:
  audience: <optional>
---

# <Human title>

## When to use this skill
<short trigger guidance; keep the strongest trigger cues in the frontmatter description>

## Inputs I need
- ...

## Output contract
<exact template or checklist>

## Procedure
1. ...
2. ...

## Examples
<2-3 realistic examples>
```

### 4) Draft a small test set

Create 3-6 realistic prompts:

- 2-3 should-trigger prompts spanning different phrasings.
- 1-2 near-miss prompts that should not trigger (share keywords but differ in intent).
- 0-1 "edge case" prompt (missing input, ambiguous requirement, unusual repo layout).

If the environment supports subagents, you can optionally run a quick A/B sanity check:

- Baseline: run the prompt without loading the new skill.
- With-skill: run the same prompt after loading the skill.

Evaluate qualitatively:

- Did it ask the right clarifying questions?
- Did it follow the output contract?
- Did it avoid unnecessary work or risky actions?

### 5) Iterate

Make one kind of improvement at a time:

- If the skill is misfiring: improve `description` and the "When to use" guidance.
- If outputs are inconsistent: tighten the output contract/template.
- If it's verbose or slow: remove steps that don't change outcomes.
- If it's too narrow: add 1-2 more examples and clarify general rules.

## Description writing guidance

The frontmatter `description` is the primary trigger signal.

- Include both what it does and when to use it.
- Prefer concrete cues (artifacts, workflows, nouns) over generic verbs.
- Include a couple of common user phrasings.
- Avoid provider names or model-specific instructions.

## Safety

- Do not encode instructions that facilitate unauthorized access, deception, or data exfiltration.
- If the requested skill could be dual-use, ask the user for intended legitimate use and add safe defaults.
