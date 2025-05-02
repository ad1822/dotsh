#!/bin/bash

set -e

TYPE=$(gum choose --header="Select the commit type:" \
  "feat" "fix" "docs" "style" "refactor" "test" "chore" "revert")

EMOJI=$(gum choose --header="Choose an emoji (optional):" \
  "🚀" "🐛" "📝" "🎨" "🔨" "✅" "🔁" "📦" "❌" "⬆️" "⬇️" "🔥" "None")

[[ "$EMOJI" == "None" ]] && EMOJI=""

SUMMARY=$(gum input --placeholder "Summary of this change (e.g., Add logging to payment flow)")
if [[ -z "$SUMMARY" ]]; then
  echo "❌ Summary is required. Exiting."
  exit 1
fi

DESCRIPTION=$(gum write --placeholder "Details (Optional)")

FINAL_SUMMARY="$TYPE $EMOJI : $SUMMARY"

echo -e "\n📦 Commit Preview:"
#echo "$FINAL_SUMMARY"
echo -e "\033[1;32m$TYPE\033[0m \033[1;33m$EMOJI\033[0m : \033[1;36m$SUMMARY\033[0m"

echo ""

[[ -n "$DESCRIPTION" ]] && echo "$DESCRIPTION"

if gum confirm "Commit with above message?"; then
  git commit -m "$FINAL_SUMMARY" ${DESCRIPTION:+-m "$DESCRIPTION"}
else
  echo "❌ Commit cancelled."
fi

