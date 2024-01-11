#!/bin/bash

echo "Repository: $GITHUB_REPOSITORY"
echo "PR Number: $PR_NUMBER"
echo "PR Title: $PR_TITLE"
echo "PATTERN: $PATTERN"
echo "PR_REVIEWERS: $PR_REVIEWERS"
echo "GITHUB_TOKEN: $GITHUB_TOKEN"
echo "REVIEWER: $REVIEWER"
echo "PR_TEAM_REVIEWERS: $PR_TEAM_REVIEWERS"
echo "TEAM_MEMBERS: $team_members"
echo "APPROVED: $approved"

# GitHub API URLs
API_REVIEWERS_URL="https://api.github.com/repos/$GITHUB_REPOSITORY/pulls/$PR_NUMBER/requested_reviewers"

add_reviewer() {
  gh pr edit "$PR_NUMBER" --add-reviewer "$REVIEWER"
}

remove_reviewer() {
    curl -X DELETE -H "Authorization: token $GITHUB_TOKEN" -H "Accept: application/vnd.github.v3+json" "$API_REVIEWERS_URL" \
    -d "{\"reviewers\": [\"$REVIEWER\"]}"
}


if [[ $PR_TITLE =~ $PATTERN ]]; then
  echo "PR title matches the pattern"
  if [[ $PR_REVIEWERS != *"$REVIEWER"* ]]; then
    echo "Reviewer is not present yet, adding reviewer"
    # Add reviewer
    add_reviewer

    echo "Reviewer added"
  fi
else
  echo "PR title does not match the pattern"
  if [[ $PR_REVIEWERS == *"$REVIEWER"* ]]; then
    echo "Removing reviewer as was added and PR title does not match the pattern"
    # Remove reviewer
    remove_reviewer
  fi
fi
