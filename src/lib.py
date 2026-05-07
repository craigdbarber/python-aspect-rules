"""A simple library using the requests dependency."""

from typing import Any

import requests


def fetch_data(url: str) -> dict[str, Any]:
    """Fetches JSON data from a URL.

    Args:
        url: The URL to fetch data from.

    Returns:
        A dictionary containing the JSON response.
    """
    # myVar = ""
    response = requests.get(url, timeout=5)
    return response.json()
