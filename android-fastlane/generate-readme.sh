#!/bin/sh

cd $(dirname $0)
# cd $(dirname $0)/.. # Use this, if you want to put this file in an extra `scripts` directory.

FASTLANE_PATH=fastlane/metadata/android


# The output of this function will be added to the beginning of all files
function header {
echo '<div>'
  echo '<div align="left">'
    # Use this space to add stuff like CI badges, links to Jira, etc…

    # echo '<img src="https://github.com/my/repo/actions/workflows/myWorkflow.yml/badge.svg"/>'
    # echo '<a href="link to jira or whatever">Sprint board</a>'
  echo '</div>'
  echo '<div align="right">'
    # List your languages here

    # echo -n '<a href="README.md">English</a> | '
    # echo -n '<a href="README.jp.md">日本語</a> | '
    # echo '<a href="README.de.md">Deutsch</a>'
  echo '</div>'
echo '</div>'
}

function generate_readme {
  OUT=$1
  LANG=$2
  FASTLANE_PREFIX=$FASTLANE_PATH/$LANG

  header > $OUT
  echo '' >> $OUT

  echo '<div align="center">' >> $OUT
  echo "<img src=\"$FASTLANE_PREFIX/images/icon.png\" alt=\"App icon\" />" >> $OUT
  echo '</div>' >> $OUT
  echo '' >> $OUT

  echo "<h1>$(cat $FASTLANE_PREFIX/title.txt)<br><sub>$(cat $FASTLANE_PREFIX/short_description.txt)</sub></h1>" >> $OUT
  echo '' >> $OUT
  echo "> $(cat $FASTLANE_PREFIX/full_description.txt)" >> $OUT
  echo '' >> $OUT


  echo "## Screenshots" >> $OUT

  echo -n "| " >> $OUT
  for file in $FASTLANE_PREFIX/images/phoneScreenshots/*
  do
    echo -n " |" >> $OUT
  done
  echo "" >> $OUT

  echo -n "|" >> $OUT
  for file in $FASTLANE_PREFIX/images/phoneScreenshots/*
  do
    echo -n "-|" >> $OUT
  done
  echo "" >> $OUT

  echo -n "| " >> $OUT
  for file in $FASTLANE_PREFIX/images/phoneScreenshots/*
  do
    echo -n "![]($file) | " >> $OUT
  done
  echo -e '\n' >> $OUT


  echo "## Changelog" >> $OUT
  for file in $FASTLANE_PREFIX/changelogs/*
  do
    cat $file >> $OUT
    echo -e '\n' >> $OUT
  done
}

# Call the function once per language
# Usage:
# generate_readme OUTPUT_FILE LANG

generate_readme EXAMPLE.md en-US
# generate_readme README.md en-US
# generate_readme README.de.md de
# generate_readme README.jp.md jp
