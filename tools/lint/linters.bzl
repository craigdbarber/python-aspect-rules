load("@aspect_rules_lint//lint:bandit.bzl", "lint_bandit_aspect")
load("@aspect_rules_lint//lint:flake8.bzl", "lint_flake8_aspect")
load("@aspect_rules_lint//lint:pylint.bzl", "lint_pylint_aspect")
load("@aspect_rules_lint//lint:ruff.bzl", "lint_ruff_aspect")
load("@aspect_rules_lint//lint:ty.bzl", "lint_ty_aspect")
load("@aspect_rules_lint//lint:vale.bzl", "lint_vale_aspect")

ruff = lint_ruff_aspect(
    binary = "@aspect_rules_lint//lint:ruff_bin",
    configs = [Label("//:ruff.toml")],
)

pylint = lint_pylint_aspect(
    binary = Label("//tools/lint:pylint"),
    config = Label("//:pyproject.toml"),
)

vale = lint_vale_aspect(
    binary = Label("//:vale"),
    config = Label("//:.vale.ini"),
)

bandit = lint_bandit_aspect(
    binary = Label("//tools/lint:bandit"),
    config = Label("//:pyproject.toml"),
)

flake8 = lint_flake8_aspect(
    binary = Label("//tools/lint:flake8"),
    config = Label("//:.flake8"),
)

ty = lint_ty_aspect(
    binary = Label("@aspect_rules_lint//lint:ty_bin"),
    config = Label("//:pyproject.toml"),
)
