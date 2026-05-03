# Python Aspect Rules Demo

A modern Python project demonstrating the integration of **Bazel** (via `aspect_rules_py`), **uv** for dependency management, and a robust linting/formatting toolchain.

## Features

- **Python 3.14**: Utilizing the latest Python features and hermetic toolchains.
- **Bazel (Bzlmod)**: High-performance build system with modular dependency management.
- **uv Integration**: Fast, reliable Python dependency resolution and locking.
- **Automated Formatting**: Ruff-based formatting integrated into the Bazel workflow.
- **Advanced Linting**: Combined Pylint (logic/performance) and Ruff (security/style) audits.
- **Unit Testing**: Pytest integration with hermetic execution.

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
Formatting is handled by **Ruff** and is automatically executed by a Bazel wrapper script (`tools/bazel`) before builds.

Linting is configured as Bazel aspects:
- **Pylint**: For deep logic and performance analysis.
- **Ruff (Bandit)**: For automated security auditing.

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

### Running Audits (Linting)
To run logic and security audits across the entire project:

```bash
bazel build --config=lint //...
```

### Manual Formatting
To manually trigger the code formatter:

```bash
bazel run //tools/format
```

### Adding Dependencies
To add a new package:

```bash
uv add requests
bazel run //:main
```

## Engineering Standards

This project adheres to the standards defined in `GEMINI.md`, including Google docstring conventions, comprehensive type hinting, and the Git Flow workflow.
