#!/bin/bash

echo "PR Number: $PR_NUMBER"
echo "PR Title: $PR_TITLE"
echo "PATTERN: $PATTERN"
echo "REVIEWER: $REVIEWER"
echo "HAS_FE_REVIEW_REQUEST: $HAS_FE_REVIEW_REQUEST"
echo "IS_APPROVED_BY_FE: $IS_APPROVED_BY_FE"

add_reviewer() {
  gh pr edit "$PR_NUMBER" --add-reviewer "$REVIEWER"
}

if [ "$IS_APPROVED_BY_FE" == "true" ]; then
  echo "PR has approaval from FE, skipping adding reviewer"
  exit 0
fi

if [[ $PR_TITLE =~ $PATTERN ]]; then
  echo "PR title matches pattern, checking if reviewer is present"
  if [ "$HAS_FE_REVIEW_REQUEST" != "true" ]; then
    echo "Reviewer is not present yet, adding reviewer"
    # Add reviewer
    add_reviewer

    echo "Reviewer added"
  fi

  exit 1
fi
