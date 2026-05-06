# Bazel Architecture & Design

This document describes the design and architecture of the build configuration for the `python-aspect-rules-demo` project.

## Architecture Overview

The project utilizes a modern Bazel 8 (Bzlmod) architecture focused on hermeticity, performance, and developer experience. It integrates `uv` for dependency management and `aspect_rules_lint` for a decoupled linting workflow.

### Design Diagram

```mermaid
graph TD
    User([User/CLI]) --> Bazelisk[Bazelisk Launcher]
    Bazelisk --> Wrapper[tools/bazel Wrapper]
    
    subgraph "Execution Phase"
        Wrapper -->|Auto-format| RuffFmt[Ruff Formatter]
        Wrapper -->|Delegate| BazelBin[Bazel Binary]
    end
    
    subgraph "Dependency Management"
        BazelBin --> UVExt[UV Module Extension]
        UVExt --> UVLock[uv.lock]
        UVExt --> PyProject[pyproject.toml]
        UVExt --> Hub[@pypi Repo Hub]
    end
    
    subgraph "Build & Audit"
        BazelBin --> Targets[Build Targets //:lib, //:main]
        BazelBin -->|Aspects| Linters[Pylint & Ruff Aspects]
        BazelBin -->|Tests| Pytest[Pytest Runner]
        BazelBin -->|Security| Bandit[Bandit Standalone Test]
    end
```

## Core Dependencies

The project relies on several key Bazel rule sets:

| Dependency | Purpose | Documentation |
| :--- | :--- | :--- |
| **aspect_rules_py** | High-performance Python rules and `uv` integration. | [Docs](https://github.com/aspect-build/rules_py) |
| **aspect_rules_lint** | Decoupled linting and formatting infrastructure. | [Docs](https://github.com/aspect-build/rules_lint) |
| **rules_python** | Official Bazel Python rules (toolchain support). | [Docs](https://github.com/bazelbuild/rules_python) |
| **aspect_bazel_lib** | Common utility functions for Bazel rules. | [Docs](https://github.com/aspect-build/bazel-lib) |

## The `tools` Folder

The `tools/` directory contains custom scripts and configurations that extend Bazel's functionality:

### `tools/bazel` (The Wrapper)
A Bash script that acts as an interceptor for all Bazel commands.
- **Why**: To ensure code is formatted before it is built or tested without requiring manual developer action.
- **How**: Bazelisk automatically detects this file and executes it. It triggers `bazel run //tools/format` locally but skips it in CI to ensure build immutability.

### `tools/format`
Contains the `format_multirun` target.
- **Why**: Provides a unified entry point to run formatters across the project.
- **Integration**: Configured to use **Ruff** for Python formatting.

### `tools/lint`
Contains linter runners and aspect definitions.
- **Pylint**: A `py_binary` runner that wraps Pylint for hermetic execution.
- **Bandit**: A `py_binary` and `py_test` for security auditing.
- **Aspects**: Defined in `linters.bzl`, these allow linting to run "on the side" of the build graph without being hard-coded into every library target.

## Tool Integrations

### Bazelisk
The project uses **Bazelisk** as the launcher. It ensures the correct version of Bazel (defined in `.bazelversion`) is used and manages the execution of the `tools/bazel` wrapper.

### uv
Dependency resolution is handled by [uv](https://github.com/astral-sh/uv). 
- **Workflow**: Developers use `uv lock` to update dependencies.
- **Integration**: Bazel's `uv` module extension (via `aspect_rules_py`) parses `uv.lock` and creates a `@pypi` repository hub, making Python packages available as standard Bazel targets.

### Pylint & Bandit
- **Pylint**: Integrated via a Bazel aspect for logical and performance auditing. It is triggered during the linting phase (`--config=lint`).
- **Bandit**: Integrated in two ways:
    1. **Ruff Aspect**: Fast security checks as part of the standard linting workflow.
    2. **Standalone Test**: A `py_test` target (`//tools/lint:bandit_test`) that performs a deep recursive scan of the `src/` directory to ensure no vulnerabilities are missed.
