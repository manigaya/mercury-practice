#!/bin/bash
# One-time setup: points the app at your own GitHub repo. Usage: bash setup.sh YOUR_GITHUB_USERNAME
set -e

if [ -z "$1" ]; then
  echo "Usage: bash setup.sh YOUR_GITHUB_USERNAME"
  exit 1
fi

cd "$(dirname "$0")"
start_branch=$(git rev-parse --abbrev-ref HEAD)

for branch in solution main; do
  git checkout -q "$branch"
  perl -pi -e "s/YOUR_GITHUB_USERNAME/$1/g" MercuryPractice/Config.swift
  git -c user.name="Practice Setup" -c user.email="setup@example.com" \
    commit -q -am "Point API at github.com/$1/mercury-practice"
done

git checkout -q "$start_branch"
echo "Done! Config.swift now uses github.com/$1/mercury-practice on both branches."
echo "Next: publish the repo with GitHub Desktop (see PRACTICE.md, step 4)."
