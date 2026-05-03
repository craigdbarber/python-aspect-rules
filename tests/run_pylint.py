"""A runner script for pylint under Bazel."""

from pylint import lint

if __name__ == "__main__":
    # pylint.lint.Run by default calls sys.exit() with the exit code.
    lint.Run(["src", "tests"])
