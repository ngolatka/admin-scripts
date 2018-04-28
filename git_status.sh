#!/bin/bash

# Show the Git status for each repository.

repos=(
"/etc"
)

for repo in "${repos[@]}";
do

  cd $repo
  echo "Repo: `pwd`"
  git status
  echo "--------"

done
