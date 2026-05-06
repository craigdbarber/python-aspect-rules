# Bazel Python Hermetic Blueprint

A modern Python project demonstrating the integration of **Bazel** (via `aspect_rules_py`), **uv** for dependency management, and a robust linting/formatting toolchain.

## Features

- **Python 3.14**: Utilizing the latest Python features and hermetic toolchains.
- **Bazel (Bzlmod)**: High-performance build system with modular dependency management.
- **uv Integration**: Fast, reliable Python dependency resolution and locking.
- **Automated Formatting**: Ruff-based formatting integrated into the Bazel workflow.
- **Advanced Linting**: Combined Pylint (logic/performance) and Ruff (security/style) audits.
- **Unit Testing**: Pytest integration with hermetic execution.

## Architecture

For a detailed deep-dive into the build system design, dependencies, and tool integrations, see the [Build Architecture & Design](build-architecture.md) document.

## Prerequisites

- [uv](https://github.com/astral-sh/uv)
- [Bazelisk](https://github.com/bazelbuild/bazelisk) (or Bazel 8.2.0+)

## Configuration

### Dependency Management
Dependencies are defined in `pyproject.toml`. To update the lockfile, use `uv`:

```bash
uv lock
```

Bazel automatically ingests `uv.lock` via the `uv` module extension.

### Formatting & Linting
Formatting is handled by **Ruff** and is automatically executed by a Bazel wrapper script (`tools/bazel`) before builds (except in CI, where it is enforced via a check).

Linting is configured as Bazel aspects:
- **Pylint**: For deep logic and performance analysis.
- **Ruff (Bandit)**: For automated security auditing.
- **Bandit (Standalone)**: A dedicated test target for deep security analysis.

## Usage Examples

### Running the Application
To run the main entry point:

```bash
bazel run //:main
```

### Running Tests
To execute unit tests via Pytest:

```bash
bazel test //:test_lib
```

To run the dedicated security audit:

```bash
bazel test //tools/lint:bandit_test
```

To run the markdown documentation audit:

```bash
bazel test //tools/lint:markdown_lint_test
```

### Running Audits (Linting)
To run logic and security audits across the entire project:

```bash
bazel build --config=lint //...
```

You can also run the standalone Bandit tool via an alias:

```bash
bazel run //:bandit -- -r src
```

### Formatting
To manually trigger the code formatter:

```bash
bazel run //tools/format
```

To check formatting without modifying files (e.g., for CI):

```bash
bazel run //tools/format -- --check
```

### Adding Dependencies
To add a new package:

```bash
uv add requests
uv lock
bazel run //:main
```

## Technology Stack

This project leverages the following best-in-class tools and libraries:

### Build System & Core
- [**Bazel**](https://bazel.build): The core build and test runner.
- [**Bazelisk**](https://github.com/bazelbuild/bazelisk): A user-friendly launcher for Bazel.
- [**uv**](https://github.com/astral-sh/uv): Extremely fast Python package installer and resolver.
- [**aspect_rules_py**](https://github.com/aspect-build/rules_py): Advanced Bazel rules for Python with uv integration.
- [**rules_python**](https://github.com/bazelbuild/rules_python): Official Bazel rules for Python.
- [**aspect_bazel_lib**](https://github.com/aspect-build/bazel-lib): Common utility libraries for Bazel rules.

### Linting, Formatting & Security
- [**Ruff**](https://docs.astral.sh/ruff/): An extremely fast Python linter and code formatter.
- [**Pylint**](https://pylint.readthedocs.io/): A comprehensive static code analysis tool for Python.
- [**Bandit**](https://bandit.readthedocs.io/): A tool designed to find common security issues in Python code.
- [**Vale**](https://vale.sh): A syntax-aware linter for prose and documentation.
- [**aspect_rules_lint**](https://github.com/aspect-build/rules_lint): A Bazel framework for running linters and formatters.

### Python Libraries
- [**Pytest**](https://docs.pytest.org/): A mature full-featured Python testing tool.
- [**requests**](https://requests.readthedocs.io/): An elegant and simple HTTP library for Python.
