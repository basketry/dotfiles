# add scripts to package.json
jq '
  .scripts += {
    "prebuild": "run-s -s clean lint",
    "build": "tsc",
    "clean": "run-s -s clean:*",
    "clean:coverage": "rimraf coverage",
    "clean:output": "rimraf lib",
    "fix": "run-s -s fix:*",
    "fix:eslint": "eslint --fix",
    "fix:prettier": "prettier -w . --config ./node_modules/@basketry/dotfiles/.prettierrc --ignore-path .gitignore",
    "lint": "run-s -s lint:*",
    "lint:eslint": "eslint --config ./node_modules/@basketry/dotfiles/eslint.config.mjs .",
    "lint:prettier": "prettier -c . --config ./node_modules/@basketry/dotfiles/.prettierrc --ignore-path .gitignore",
    "prepack": "run-s -s build",
    "pretest": "run-s -s clean",
    "test": "node --experimental-vm-modules ./node_modules/.bin/jest --config ./node_modules/@basketry/dotfiles/jest.config.json --rootDir ."
  }
' package.json > temp.json && mv temp.json package.json

# Sort scripts
jq '
  .scripts |= (
    to_entries | 
    sort_by(
      .key | sub("^(pre|post)"; "") + if test("^pre") then "0" else "1" end
    ) | 
    from_entries
  )
' package.json > temp.json && mv temp.json package.json

# Update tsconfig.json
touch tsconfig.json
[ ! -s tsconfig.json ] && echo '{}' > tsconfig.json
jq --arg path "./node_modules/@basketry/dotfiles/tsconfig.json" \
   '.extends = $path' tsconfig.json > tsconfig.tmp && mv tsconfig.tmp tsconfig.json

# Check if .gitignore exists; if not, download it and append 'lib/'
if [ ! -f .gitignore ]; then
  curl -o .gitignore https://raw.githubusercontent.com/github/gitignore/refs/heads/main/Node.gitignore
  echo -e "\n\n# Typescript output\nlib/" >> .gitignore
fi