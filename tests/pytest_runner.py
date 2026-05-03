"""A simple pytest runner for Bazel integration.

This script provides a manual entry point for pytest to run within the
Bazel environment, ensuring that test discovery and execution work
correctly with Bazel's runfiles.
"""

import sys

import pytest


def main() -> None:
    """Main entrypoint for the pytest runner."""
    sys.exit(pytest.main(sys.argv[1:]))


if __name__ == "__main__":
    main()
