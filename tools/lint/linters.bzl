load("@aspect_rules_lint//lint:ruff.bzl", "lint_ruff_aspect")
load("@aspect_rules_lint//lint:pylint.bzl", "lint_pylint_aspect")

ruff = lint_ruff_aspect(
    binary = "@aspect_rules_lint//lint:ruff_bin",
    configs = [Label("//:ruff.toml")],
)

pylint = lint_pylint_aspect(
    binary = Label("//tools/lint:pylint"),
    config = Label("//:pyproject.toml"),
)
