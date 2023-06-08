#!/bin/sh
TYPE=$(cat commit_types.txt | gum filter --placeholder "Type of change")

SUMMARY=$(gum input --width 50 --value "$TYPE: " --placeholder "Summary of changes")
DESCRIPTION=$(gum write --width 80 --placeholder "Details of this change (CTRL+D to finish)")

git commit -m "$SUMMARY" -m "$DESCRIPTION"
