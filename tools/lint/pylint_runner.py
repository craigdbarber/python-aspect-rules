"""A runner for pylint integration in Bazel.

This script provides an entry point to run pylint as a binary target
within the Bazel build, allowing for hermetic linting.
"""

import sys

from pylint import lint


def main() -> None:
    """Main entrypoint for the pylint runner."""
    lint.Run(sys.argv[1:])


if __name__ == "__main__":
    main()
