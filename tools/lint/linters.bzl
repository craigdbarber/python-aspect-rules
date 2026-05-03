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

def _bandit_aspect_impl(target, ctx):
    # Simplified bandit aspect implementation
    load_utils = "@aspect_rules_lint//lint/private:lint_aspect.bzl"
    # Note: Starlark doesn't allow dynamic loads, so this is just a reminder
    # that I need to use the actual load statements at the top.
    return []

# We'll use a more standard approach for bandit since it's not built-in to rules_lint
# but we want to follow the project's security mandate.
# For now, we'll keep pylint as the main linter but we can add security checks to it.
