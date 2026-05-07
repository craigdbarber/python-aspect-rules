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
- **Submission**: Direct pushes to the `main` branch are strictly prohibited. All changes must be submitted via **Pull Requests** from a dedicated feature or fix branch.
- **Review Protocol**: Gemini must NOT automatically push changes to GitHub. All changes must be reviewed locally by the user. Gemini will only push after receiving explicit instruction to do so.
- **Commits**: All changes must be committed with descriptive, readable, and well-structured commit messages.
- **Code Reviews**: Every Pull Request must undergo a rigorous code review before merging. Reviews should focus on adherence to idiomatic code, readability, security best practices, and performance optimization.
- **Automated Audits**: Security linting is automated via Ruff's Bandit rule set (`S`). Performance and logic audits are performed via Pylint.

## Documentation
- **README.md**: The project must maintain a `README.md` file that documents the configuration and usage of the software in a descriptive and readable manner. It should include example use cases with in-line command line code blocks.

## Continuous Integration
- **GitHub Actions**: The project must utilize GitHub Actions for Continuous Integration. A workflow should be triggered on every push and pull request to the `main` branch, executing the unit tests, logic audits (Pylint), and security audits (Ruff-Bandit).
- **CI Monitoring & Remediation**: Once pushed (following user approval), Gemini must monitor the CI run at `https://github.com/craigdbarber/bazel-python-hermetic-blueprint/actions`. If the CI pipeline fails, Gemini must diagnose and fix the error locally, then wait for user review and push instruction for the correction.

## Build & Tooling
- **Build System**: Bazel (Bzlmod enabled).
- **Dependency Management**: `uv` (ingest `uv.lock`). Unused dependencies must be rigorously removed from `pyproject.toml`.
- **Linting**: Pylint, Ruff, Bandit, Flake8, Ty, and Buildifier via Bazel aspects.
- **Formatting**: Ruff and Buildifier via Bazel multirun.
- **Testing**: Pytest via Bazel `py_test`.
