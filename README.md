# Bazel Python Hermetic Blueprint

A modern Python project demonstrating the integration of **Bazel** (via `aspect_rules_py`), **uv** for dependency management, and a robust linting/formatting toolchain.

## Table of Contents
- [Features](#features)
- [Architecture](#architecture)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
  - [Dependency Management](#dependency-management)
  - [Formatting & Linting](#formatting--linting)
- [Usage Examples](#usage-examples)
- [Running the Application](#running-the-application)
- [Running Tests](#running-tests)
- [Running Audits (Linting)](#running-audits-linting)
- [Formatting](#formatting)
- [Adding Dependencies](#adding-dependencies)
- [Getting Started: Adopting the Blueprint](#getting-started-adopting-the-blueprint)
- [Technology Stack](#technology-stack)

## Features

- **Python 3.14**: Utilizing the latest Python features and hermetic toolchains.
- **Bazel (Bzlmod)**: High-performance build system with modular dependency management.
- **uv Integration**: Fast, reliable Python dependency resolution and locking.
- **Automated Formatting**: Ruff and Buildifier-based formatting integrated into the Bazel workflow.
- **Advanced Linting**: Combined Ruff, Bandit, Ty, and Buildifier audits.
- **Unit Testing**: Native Pytest integration with hermetic execution.

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
Formatting is handled by **Ruff** (for Python) and **Buildifier** (for Bazel/Starlark files) and is automatically executed by a Bazel wrapper script (`tools/bazel`) before builds (except in CI, where it is enforced via a check).

Linting is configured as Bazel aspects:
- **Ruff**: For fast security, style, and docstring auditing.
- **Bandit**: Dedicated security audit.
- **Ty**: Fast, Rust-based type checking.
- **Buildifier**: Linting for Bazel `BUILD`, `WORKSPACE`, and `.bzl` files.

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

## Getting Started: Adopting the Blueprint

Follow these steps to incorporate this architecture into your own project:

1. **Bootstrap**: Clone the blueprint and initialize a fresh repository.
   ```bash
   git clone https://github.com/craigdbarber/bazel-python-hermetic-blueprint.git my-new-project
   cd my-new-project
   rm -rf .git && git init
   ```

2. **Configure**: Update the project name in the following files:
   - In `MODULE.bazel`: Change `module(name = "bazel_python_hermetic_blueprint", ...)`
   - In `pyproject.toml`: Update the `name`, `version`, and `description`.
   - In `.bazelrc`: Change `common --@pypi//venv=python-aspect-rules`.
   - In `tools/lint/BUILD.bazel`: Change `deps = ["@pypi//python_aspect_rules:lib"]`

3. **Develop**: Place your application code in `src/` and tests in `tests/`.

4. **Define Targets**: Update the root `BUILD.bazel` to include your new libraries and binaries.
   ```python
   py_library(
       name = "my_lib",
       srcs = ["src/my_lib.py"],
       visibility = ["//visibility:public"],
   )
   ```

5. **Add Dependencies**: Use `uv` to manage your Python packages.
   ```bash
   uv add pandas
   uv lock
   ```

6. **Audit**: Ensure everything meets the blueprint's standards.
   ```bash
   bazel build --config=lint //...
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
- [**Bandit**](https://bandit.readthedocs.io/): A tool designed to find common security issues in Python code.
- [**Flake8**](https://flake8.pycqa.org/): A traditional tool for checking style and syntax.
- [**Ty**](https://docs.astral.sh/ty/): A fast, Rust-based type checker for Python.
- [**aspect_rules_lint**](https://github.com/aspect-build/rules_lint): A Bazel framework for running linters and formatters.

### Python Libraries
- [**Pytest**](https://docs.pytest.org/): A mature full-featured Python testing tool.
