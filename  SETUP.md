# 🪄 Claude Setup Guide for Documentation and Automation

## 🎯 Overview

This guide serves as a comprehensive setup document to assist Claude Code in generating key documentation and configuration files for this project. It includes:

* `CLAUDE.md`: Claude-specific behavioral guide
* `README.md`: Project overview
* `TESTING.md`: Testing guidelines
* `STRUCTURE.md`: Project structure explanation
* `CONTRIBUTING.md`: Contribution guidelines
* `.github/workflows/claude.yml`: GitHub Actions workflow configuration

Claude is expected not only to interpret the provided structure and intent but also to actively think, hypothesize, test, gather feedback, and iteratively improve the generated outputs to achieve optimal results.

---

## 📄 Specification Input (for Claude)

Please paste your project specification here:

```
Example contents:
- Project goals
- Functional requirements
- User types and use cases
- Technology stack
- Page or module structure
- Testing requirements
```

---

## 📁 Project Directory Structure Template

Please generate the following directory and file structure:

```
my-project/
├── .claude/
│   ├── CLAUDE.md
│   ├── goals.md
│   ├── mistakes.md
│   └── prompts.md
├── src/
│   ├── lib/
│   ├── cli/
│   ├── services/
│   ├── config/
│   └── utils/
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── docs/
│   ├── README.md
│   ├── TESTING.md
│   ├── STRUCTURE.md
│   └── CONTRIBUTING.md
├── scripts/
│   ├── setup.sh
│   ├── test.sh
│   └── format.sh
├── .github/
│   ├── workflows/
│   │   └── claude.yml
│   └── ISSUE_TEMPLATE.md
├── package.json
├── tsconfig.json
├── .eslintrc.json
├── .prettierrc
└── CLAUDE.md
```

---

## 🤖 Claude + GitHub Actions Integration

Claude Code is integrated with GitHub Actions to enable the following automations:

* Responding to issues and pull requests via `@claude` comments
* Performing automated code reviews, bug fixes, and feature generation
* Following project guidelines defined in `CLAUDE.md`

### 🔧 Setup Instructions

1. Launch Claude and run the following command:

```bash
/install-github-app
```

2. Add `ANTHROPIC_API_KEY` to GitHub repository secrets

3. Create the following GitHub Actions workflow file:

```yaml
name: Claude Assistant

on:
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]
  issues:
    types: [opened, assigned]
  pull_request_review:
    types: [submitted]

jobs:
  claude-response:
    runs-on: ubuntu-latest
    steps:
      - uses: anthropics/claude-code-action@beta
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
          github_token: ${{ secrets.GITHUB_TOKEN }}
```

---

## 🔐 Security Best Practices

Follow these practices to ensure safe operation of Claude Code and GitHub Actions:

### ✅ Secrets Management

* Store `ANTHROPIC_API_KEY` and other secrets in GitHub Secrets.
* Do not expose secrets in logs or source files.
* Confirm generated outputs do not leak sensitive data.

### ✅ Scope Limitation

* Limit Claude's operations to specific directories or pull requests.
* Define allowed tools and scopes in the workflow config.

### ✅ Output Review

* Always manually review Claude's output before merging.
* Confirm functionality via tests before accepting changes.

### ✅ Minimal Permissions

* Grant Claude GitHub App the minimum required permissions.
* Restrict trigger comments in public repositories.

### ✅ Troubleshooting

* If you encounter a `gh: Not Found` error, update GitHub CLI credentials:

```bash
gh auth refresh -h github.com -s workflow
```

* If `Raw mode is not supported` appears, ensure CI scripts avoid interactive prompts. Consider using `expect` scripts or a non-interactive fallback.

---

## 🚀 Execution Workflow

1. Launch Claude Code
2. Load and read this `SETUP.md`
3. Generate project directory structure
4. Create required documents step by step
5. Configure GitHub Actions via `claude.yml`
6. Review Claude's output and iterate based on feedback

---

## 📂 Expected Output Files

| File Path                      | Description                               |
| ------------------------------ | ----------------------------------------- |
| `.claude/CLAUDE.md`            | Behavioral instructions for Claude        |
| `README.md`                    | Project summary and onboarding            |
| `TESTING.md`                   | Testing strategy and execution guidelines |
| `STRUCTURE.md`                 | Explanation of project structure          |
| `CONTRIBUTING.md`              | Development and contribution rules        |
| `.github/workflows/claude.yml` | Claude GitHub Action configuration        |

---

## ✨ Final Notes

Claude, please execute the setup based on this document. Use your best reasoning, test your assumptions, and adapt your outputs based on feedback.

Your goal is to generate thoughtful, accurate, and high-quality results—not just to follow orders. Let's build something great together 🐻🚀
