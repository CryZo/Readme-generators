# Android Fastlane
Generates a readme file using fastlane data. Please have a look at the comments in [generate-readme.sh](generate-readme.sh) [Example](EXAMPLE.md)

## Possible integration using Github Actions
```yaml
name: Build Docs

on:
  push:
    branches:
      - main
    paths:
      # Change this to fit your paths
      - 'fastlane/**/*'
      - 'scripts/generate-readme.sh'
      - '.github/workflows/docs.yml'

jobs:
  build:
    permissions:
      contents: write
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Generate Readme
        run:  bash ${GITHUB_WORKSPACE}/scripts/generate-readme.sh

      - name: Commit and push changes
        run: |
          git config user.name github-actions
          git config user.email github-actions@github.com
          git add .
          git commit -m "Generated docs"
          git push
```