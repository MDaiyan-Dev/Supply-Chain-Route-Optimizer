#!/usr/bin/env python3
"""
geocode.py

Usage:
    python geocode.py input_addresses.csv > coords.txt

Expects a CSV with a header row containing at least these two columns:
    id,address

For each row, it sends a request to Nominatim (OpenStreetMap) with a custom User-Agent.
It prints to stdout:
    id lon lat

If a lookup fails, it prints a warning to stderr and emits lon=0.0,lat=0.0 for that ID.
"""

import csv
import sys
import time
import requests

# URL for Nominatim search
NOMINATIM_URL = "https://nominatim.openstreetmap.org/search"

# Replace this with your contact email or a descriptive user-agent.
USER_AGENT = "HandUpRouteOptimizer/1.0 (daiyan2k3@gmail.com)"

def geocode_address(address):
    """
    Query Nominatim for a given address string.
    Returns (lon, lat) as floats if successful, otherwise None.
    """
    params = {
        "q": address,
        "format": "json",
        "limit": 1,
        "email": "daiyan2k3@gmail.com"  # You can remove this line if you don't want to include an email.
        

    }
    headers = {
        "User-Agent": USER_AGENT
    }
    try:
        resp = requests.get(NOMINATIM_URL, params=params, headers=headers, timeout=10)
        resp.raise_for_status()
        data = resp.json()
        if len(data) == 0:
            return None
        lon = float(data[0]["lon"])
        lat = float(data[0]["lat"])
        return (lon, lat)
    except requests.exceptions.HTTPError as he:
        print(f"Warning: HTTPError for '{address}': {he}", file=sys.stderr)
        return None
    except Exception as e:
        print(f"Warning: geocoding failure for '{address}': {e}", file=sys.stderr)
        return None

def main():
    if len(sys.argv) < 2:
        print("Usage: python geocode.py input_addresses.csv > coords.txt", file=sys.stderr)
        sys.exit(1)

    input_csv = sys.argv[1]

    with open(input_csv, newline='', encoding='utf-8') as csvfile:
        reader = csv.DictReader(csvfile)
        # Check that columns "id" and "address" exist
        if "id" not in reader.fieldnames or "address" not in reader.fieldnames:
            print("Error: CSV must have columns 'id' and 'address'.", file=sys.stderr)
            sys.exit(1)

        coords = []
        for row in reader:
            ID = row["id"].strip()
            address = row["address"].strip()
            if ID == "" or address == "":
                print(f"Skipping empty row: id='{ID}', address='{address}'", file=sys.stderr)
                continue

            # Geocode
            result = geocode_address(address)
            if result is None:
                lon, lat = 0.0, 0.0
            else:
                lon, lat = result

            coords.append((int(ID), lon, lat))

            # Nominatim policy: at most 1 request per second
            time.sleep(1)

    # Print the resulting "ID lon lat" format, with count on first line
    n = len(coords)
    print(n)
    for ID, lon, lat in coords:
        print(f"{ID} {lon:.6f} {lat:.6f}")

if __name__ == "__main__":
    main()
# This script is designed to geocode addresses using the Nominatim API.
# It reads a CSV file with address data, queries the API, and outputs coordinates.