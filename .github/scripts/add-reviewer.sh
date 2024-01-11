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

if [ "$IS_APPROVED_BY_FE" != "true" ]; then
  if [[ $PR_TITLE =~ $PATTERN ]]; then
    if [ "$HAS_FE_REVIEW_REQUEST" != "true" ]; then
      echo "Reviewer is not present yet, adding reviewer"
      # Add reviewer
      add_reviewer

      echo "Reviewer added"
    fi
  fi
fi
