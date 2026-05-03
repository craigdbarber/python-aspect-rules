# Project Mandates

This project follows strict engineering standards to ensure code quality, maintainability, and consistent workflow.

## Python Standards
- **Type Hinting**: All Python code must utilize comprehensive type hinting to ensure type safety and clarity.
- **Docstrings**: Follow Google's Python docstring standards for all modules, classes, and functions.
- **Idiomatic Code**: Follow PEP 8 and use modern Python features (Python 3.14+).
- **Readability**: Prioritize clear, self-documenting code over cleverness.
- **DRY Principle**: Consolidate repetitive logic into clean abstractions.

## Git Workflow
- **Branching**: Utilize the **Git Flow** branch structure (`feature/`, `bugfix/`, `release/`, `hotfix/`).
- **Commits**: All changes must be committed with descriptive, readable, and well-structured commit messages.

## Build & Tooling
- **Build System**: Bazel (Bzlmod enabled).
- **Dependency Management**: `uv` (ingest `uv.lock`). Unused dependencies must be rigorously removed from `pyproject.toml`.
- **Linting**: Pylint via Bazel aspect.
- **Formatting**: Ruff via Bazel multirun.
- **Testing**: Pytest via Bazel `py_test`.
