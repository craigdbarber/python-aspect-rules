# Bazel Python Hermetic Blueprint

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
- **Code Reviews**: Every changeset must undergo a rigorous code review before merging. Reviews should focus on adherence to idiomatic code, readability, security best practices, and performance optimization.
- **Automated Audits**: Security linting is automated via Ruff's Bandit rule set (`S`). Performance and logic audits are performed via Pylint.

## Documentation
- **README.md**: The project must maintain a `README.md` file that documents the configuration and usage of the software in a descriptive and readable manner. It should include example use cases with in-line command line code blocks.

## Continuous Integration
- **GitHub Actions**: The project must utilize GitHub Actions for Continuous Integration. A workflow should be triggered on every push and pull request to the `main` branch, executing the unit tests, logic audits (Pylint), and security audits (Ruff-Bandit).

## Build & Tooling
- **Build System**: Bazel (Bzlmod enabled).
- **Dependency Management**: `uv` (ingest `uv.lock`). Unused dependencies must be rigorously removed from `pyproject.toml`.
- **Linting**: Pylint via Bazel aspect.
- **Formatting**: Ruff via Bazel multirun.
- **Testing**: Pytest via Bazel `py_test`.
