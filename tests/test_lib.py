"""Tests for lib.py."""

from src.lib import fetch_data


def test_fetch_data() -> None:
    """Verifies that fetch_data returns the expected URL from httpbin.org.

    This test checks for the presence of the 'url' key in the response
    and ensures it matches the requested URL.
    """
    data = fetch_data("https://httpbin.org/get")
    assert "url" in data
    assert data["url"] == "https://httpbin.org/get"
