"""A runner for pydoclint integration in Bazel."""

import sys

from pydoclint.main import main

if __name__ == "__main__":
    # pylint: disable=no-value-for-parameter,missing-kwoa
    sys.exit(main())
