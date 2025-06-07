#!/usr/bin/env python3

import requests
import datetime
import json
from collections import OrderedDict

# --- CONFIG ---
GITHUB_USERNAME = "ad1822"
GITHUB_PAT = "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"

# --- DATE SETUP ---
today = datetime.date.today()
start_of_week = today - datetime.timedelta(days=today.weekday())
from_date = start_of_week.isoformat() + "T00:00:00Z"
to_date = today.isoformat() + "T23:59:59Z"

# --- GRAPHQL QUERY ---
query = """
query($user: String!, $from: DateTime!, $to: DateTime!) {
  user(login: $user) {
    contributionsCollection(from: $from, to: $to) {
      contributionCalendar {
        weeks {
          contributionDays {
            date
            contributionCount
            weekday
          }
        }
      }
    }
  }
}
"""

variables = {
    "user": GITHUB_USERNAME,
    "from": from_date,
    "to": to_date
}

headers = {
    "Authorization": f"Bearer {GITHUB_PAT}",
    "Accept": "application/vnd.github.v4.idl"
}

# Unicode circle characters
CIRCLE_FILLED = "●"
CIRCLE_EMPTY = "○"

def get_weekday_name(weekday):
    """Convert weekday number (0-6) to abbreviated name"""
    return ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][weekday]

try:
    # --- API REQUEST ---
    response = requests.post(
        "https://api.github.com/graphql",
        json={"query": query, "variables": variables},
        headers=headers,
        timeout=10
    )
    response.raise_for_status()
    data = response.json()

    # --- PARSE RESULT ---
    weeks = data["data"]["user"]["contributionsCollection"]["contributionCalendar"]["weeks"]

    # Initialize contributions for all days of the week
    contributions = OrderedDict()
    for i in range(7):
        day = start_of_week + datetime.timedelta(days=i)
        contributions[day] = 0

    # Fill in actual contributions
    for week in weeks:
        for day in week["contributionDays"]:
            date = datetime.date.fromisoformat(day["date"])
            if start_of_week <= date <= today:
                contributions[date] = day["contributionCount"]

    # Generate heatmap dots and tooltip
    dots = []
    tooltip_lines = []
    total_contributions = 0

    for date, count in contributions.items():
        dots.append(CIRCLE_FILLED if count > 0 else CIRCLE_EMPTY)
        weekday = get_weekday_name(date.weekday())
        tooltip_lines.append(f"{weekday}: {count} contribution{'s' if count != 1 else ''}")
        total_contributions += count

    # Prepare final output
    output = {
        "text": " ".join(dots),
        "tooltip": "\n".join([f"GitHub Contributions ({start_of_week} to {today})",
                             f"Total: {total_contributions}"] + tooltip_lines),
        "class": "github-contributions",
        "alt": "GitHub Contributions"
    }

except requests.exceptions.RequestException as e:
    output = {
        "text": "⚠",
        "tooltip": f"GitHub API error: {str(e)}",
        "class": "error",
        "alt": "GitHub Error"
    }
except Exception as e:
    output = {
        "text": "⚠",
        "tooltip": f"Error: {str(e)}",
        "class": "error",
        "alt": "Error"
    }

print(json.dumps(output))