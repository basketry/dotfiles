# Basketry "dotfiles"

A shared configuration package for Basketry components implemented as Typescript NPM packages. This package provides centralized configurations (e.g., ESLint, Prettier, TypeScript) and automation tools for setting up essential files like `package.json` across multiple repositories. The goal is to maintain consistency and reduce duplication of configuration logic across all repositories.

## Features

- Shared TypeScript Configuration: Easily extendable `tsconfig.json`.
- Prettier and ESLint Configurations: Standardized code formatting and linting rules.
- Automatic Initialization: Use `npx dotfiles-init` to sync critical files like `package.json`.
- Centralized NPM Scripts: Shared scripts for linting, formatting, and testing.

## Installation

Add the package to your project as a dev dependency:

```sh
npm install --save-dev @basketry/dotfiles
```

## Usage

Run the following command to apply any required configurations or update essential files (like package.json):

```sh
npx dotfiles-init
```

This command:

- Adds or updates common NPM scripts (e.g., lint, format, test) in your package.json.
- Creates a tsconfig.json file or updates the existing one to extend the shared config.
- Ensures your project extends shared TypeScript, Prettier, and ESLint configurations.
- Adds a Node-idiomatic .gitignore file if one doesn't exist.

## Updating the Package

When the @basketry/dotfiles package is updated, simply run:

```sh
npm install @basketry/dotfiles@latest
npx dotfiles-init
```

This ensures your project stays up-to-date with the latest configurations and scripts.
