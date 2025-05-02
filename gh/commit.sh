#!/bin/bash

set -e

TYPE=$(gum choose --header="Select the commit type:" \
"feat" "fix" "docs" "style" "refactor" "test" "chore" "revert")

SCOPE=$(gum input --placeholder "Optional scope (e.g. parser)")
if [[ -n "$SCOPE" ]]; then
    SCOPE="(${SCOPE})"
fi

EMOJI=$(gum choose --no-limit --header="Pick an optional emoji:" \
"🚀" "🐛" "📝" "🎨" "🔧" "♻️" "✅" "⏪️" "❓" "❗" "🚨" "📦" "🔖" "🔒️" "⬆️" "⬇️" "No emoji")

[[ "$EMOJI" == "No emoji" ]] && EMOJI=""

SUMMARY=$(gum input --value "$TYPE$SCOPE: " --placeholder "Summary (required)")
#if [[ -z "$SUMMARY" ]]; then
#    echo "❌ Summary cannot be empty."
#    exit 1
#fi

DESCRIPTION=$(gum write --placeholder "Optional: Add a longer description...")

gum confirm "Commit changes with message: $SUMMARY ?" && \
git commit -m "$EMOJI $SUMMARY" -m "$DESCRIPTION"
