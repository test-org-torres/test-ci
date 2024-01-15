#!/bin/bash

echo "PR Number: $PR_NUMBER"
echo "PR Title: $PR_TITLE"
echo "PATTERN: $PATTERN"
echo "REVIEWER: $REVIEWER"
echo "HAS_FE_REVIEW_REQUEST: $HAS_FE_REVIEW_REQUEST"
echo "WAS_REVIEWED_BY_FE: $WAS_REVIEWED_BY_FE"

add_reviewer() {
  gh pr edit "$PR_NUMBER" --add-reviewer "$REVIEWER"
}

if [[ $PR_TITLE =~ $PATTERN ]]; then
  echo "PR title matches pattern, checking if reviewer is present"
  if [ "$HAS_FE_REVIEW_REQUEST" != "true" ]; then
  echo "PR has not review request to the FE team, checking if was reviewed by a member already"
    if [ "$WAS_REVIEWED_BY_FE" != "true" ]; then
      echo "Not reviewed by a FE member, adding reviewer"

      add_reviewer
      echo "Reviewer added"
    fi
  fi
fi
