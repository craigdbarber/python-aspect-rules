"""Main application entrypoint."""

import sys

from src.lib import fetch_data


def main() -> None:
    """Fetch and print data from httpbin.org using the library.

    This function demonstrates the basic usage of the fetch_data utility
    to retrieve JSON data from a public API.
    """
    print("Fetching data from httpbin.org...")
    try:  # pylint: disable=too-many-try-statements
        data = fetch_data("https://httpbin.org/get")
        print(f"Success! URL from response: {data.get('url')}")
    except Exception as e:  # pylint: disable=broad-exception-caught
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
