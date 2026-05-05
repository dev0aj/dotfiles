---
name: python-uv-setup
description: >-
  Initialize or augment a Python project using uv for env/deps plus ruff, pyright,
  and isort, with a simple structure and minimal boilerplate. Trigger when the
  user asks to "set up a Python project with uv" or similar.
license: MIT
compatibility: opencode
metadata:
  audience: developers
---

# Python Project Setup with uv, ruff, pyright, isort

## When to use this skill

Use this skill when the user wants to:
- Initialize a new Python project using `uv` for environment and dependency management.
- Add or standardize tooling in an existing Python project: `ruff`, `pyright`, `isort` (and optionally formatting via `ruff` or `black`).
- Get a minimal, clean project structure without heavy scaffolding or unnecessary boilerplate.

Typical trigger phrases:
- "Initialize a Python project with uv"
- "Set up Python tooling with uv, ruff, pyright, isort"
- "Add uv + ruff + pyright to this repo"

Avoid using this skill when the user is asking for:
- Non-Python stacks or polyglot monorepo tooling.
- Very opinionated frameworks (e.g. Django cookiecutters, complex service templates).

## Inputs I need

- The current working directory (this repo or folder) where the project should be set up.
- The Python version to target (ask the user; do not assume). Examples: `3.11`, `3.12`.
- Whether there is already a Python project structure present (detect via existing `pyproject.toml`, `uv.lock`, `src/` or package directories, etc.).
- The user's preferences for:
  - Using `ruff` as the formatter vs adding `black` explicitly.
  - Project layout if nothing exists yet: simple `src/` layout vs flat module (default to a simple `src/` + one package with a short name derived from the directory name).

## Output contract

By the end of the workflow, aim to produce:

1. `uv`-based project configuration
   - A `pyproject.toml` suitable for `uv` (create or update, without discarding unrelated existing config).
   - A `uv.lock` file if/when dependencies are added.

2. Tooling configuration
   - `ruff` configured for linting (and optionally formatting) via `pyproject.toml` or `ruff.toml`.
   - `pyright` configuration via `pyrightconfig.json` or `pyproject.toml` section, with sensible defaults.
   - `isort` configured, preferably integrated via `pyproject.toml` (aligned with `ruff` where possible).

3. Minimal project structure
   - If no code exists: create a minimal structure such as:
     - `src/<package_name>/__init__.py`
   - If code already exists: do not move files; only add what is necessary for tooling to work.

4. Git initialization and ignore rules
   - Initialize a git repository if one is not already present.
   - A `.gitignore` that at least ignores:
     - Python bytecode (`__pycache__/`, `*.py[cod]`)
     - Virtualenv/uv environments (e.g. `.venv/`, `.python/` if relevant)
     - Common tool caches (e.g. `.ruff_cache/`, `.pytest_cache/` if applicable).

5. Basic documentation
   - A `README.md` if none exists, including at minimum:
     - Project name.
     - Required Python version.
     - How to install dependencies with `uv`.
     - How to run linting, type checking, and formatting.

6. Verification
   - Commands to run (and, when possible, actually run) to verify setup:
     - `uv run ruff check .`
     - `uv run pyright`
     - `uv run isort --check-only .` (if configured separately)
   - Report back which commands were executed and whether they passed.

## Procedure

1. Clarify requirements
   1. Ask the user for the target Python version (e.g. `3.11`).
   2. Ask whether they prefer:
      - `ruff` as both linter and formatter, or
      - `ruff` for linting plus `black` for formatting.
   3. If the directory is empty or nearly empty, ask if they want a simple `src/<package_name>` layout or a flat layout.

2. Inspect the current directory
   1. Check for existing Python project indicators: `pyproject.toml`, `requirements.txt`, `uv.lock`, `src/`, `*.py` files.
   2. If a `pyproject.toml` exists, read it and summarize any existing:
      - Build system settings.
      - Dependencies.
      - Tool sections related to `ruff`, `pyright`, `isort`, or `black`.
   3. Confirm with the user before changing or merging into any existing tooling configuration.

3. Set up or update pyproject for uv
   1. If no `pyproject.toml` exists:
      - Create a minimal `pyproject.toml` configured for `uv`, including:
        - Project metadata: name (derived from directory), version, description (placeholder is fine), authors (optional).
        - Required Python version (from user input).
   2. If `pyproject.toml` exists:
      - Merge in `uv`-friendly configuration without removing unrelated sections.
      - Avoid changing existing metadata unless the user asks for it.

4. Configure dependencies via uv
   1. Ensure `uv` is available or instruct the user how to install it if missing.
   2. Add development dependencies using `uv` (or by editing `pyproject.toml` if preferred in this environment):
      - `ruff`
      - `pyright`
      - `isort`
      - `black` only if the user opted for it.
   3. Generate or update `uv.lock` if appropriate.

5. Configure tooling
   1. For `ruff`:
      - Add a `tool.ruff` section in `pyproject.toml` (preferred) or a `ruff.toml` file.
      - Set sensible defaults (e.g. select common rule sets, exclude typical build/artifact dirs).
      - Configure formatting-related options with the following defaults when enabling ruff formatting:
        - `line-length = 120`
        - `quote-style = "double"`
        - `indent-style = "space"`
   2. For `pyright`:
      - Create or update `pyrightconfig.json` (or equivalent configuration in `pyproject.toml` if desired).
      - Enable strictness appropriate for a new project by default, but keep it reasonable (e.g. not fully strict on existing legacy code unless user requests).
   3. For `isort`:
      - Add `tool.isort` in `pyproject.toml`, aligning sections and profiles with `ruff` and `black` if used.

6. Create or respect project structure
   1. If code already exists:
      - Do not move files or rename packages unless explicitly requested.
      - Only add missing minimal files (e.g. `__init__.py` for packages) when clearly safe.
   2. If no code exists and the user wants a simple structure:
      - Create `src/<package_name>/__init__.py`.
      - Optionally add a tiny example module, keeping it minimal.

7. Initialize git and ignore rules
   1. If the directory is not a git repo, run git initialization.
   2. Create or update `.gitignore` to include Python and tool-related ignores without deleting existing entries.

8. Create or update README
   1. If `README.md` does not exist, create a minimal one with:
      - Project title.
      - Python version requirement.
      - Commands to install dependencies and run lint, type-check, and format using `uv`.
   2. If `README.md` exists, append a short "Development" or "Tooling" section summarizing the new commands.

9. Verify and report
   1. Offer to run key commands:
      - `uv run ruff check .`
      - `uv run pyright`
      - `uv run isort --check-only .` (if applicable)
   2. Run them if the user agrees; capture and summarize results.
   3. Clearly state any follow-up actions needed (e.g. fixing initial lint/type issues) but do not silently modify code beyond what was agreed.

## Examples

Example 1: New project in empty directory

> "Create a new Python project here using uv, ruff, pyright and isort. Keep the structure simple and avoid heavy boilerplate."

Expected behavior:
- Ask for Python version and basic layout preference.
- Create `pyproject.toml` configured for `uv` and tooling.
- Create a minimal `src/<package_name>` package.
- Initialize git, add `.gitignore`, and create a basic `README.md`.

Example 2: Add tooling to an existing project

> "This repo already has some Python code. Set up uv, ruff, pyright, and isort without restructuring things."

Expected behavior:
- Detect existing `pyproject.toml` or other config.
- Merge in `uv` and tool settings without overwriting unrelated sections.
- Add dev dependencies and basic config files as needed.
- Avoid creating extra example code or complex scaffolding.

Example 3: Clarifying formatter choice

> "Set up uv and ruff for this Python project. I also want black for formatting."

Expected behavior:
- Ask for Python version if not specified.
- Add `black` as a dev dependency alongside `ruff`, `pyright`, and `isort`.
- Configure `ruff` and `isort` in a way that plays well with `black`.

## Test prompts

Prompts that should trigger this skill:
- "Initialize a Python project using uv, ruff, pyright, and isort in this folder."
- "Set up uv-based tooling (ruff, pyright, isort) for this existing Python repo without adding a lot of boilerplate."
- "Configure this project to use uv for dependencies and add linting/formatting with ruff (and maybe black) plus type checking with pyright."

Near-miss prompts that should not trigger:
- "Set up a JavaScript project with pnpm and ESLint."
- "Create a complex Django microservice template with Docker and CI pipelines."

Edge-case prompt:
- "This directory has a mix of Python and non-Python code. Can you standardize tooling across everything?" (The skill should focus only on the Python part and, if needed, ask the user whether non-Python setup is out of scope.)
