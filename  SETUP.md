# 🪄 Claude Setup Guide

## 🧭 Purpose

This guide outlines the recommended setup process for projects using Claude Code. It ensures consistent project initialization, documentation generation, task automation, and best practices in version control and security. Claude is expected to act autonomously—reasoning, testing, and improving iteratively to deliver reliable results.

---

## 📘 Specification Reference

Claude must consult the following specification file before generating any content:

```
docs/specification.md
```

This document includes:

* Project goals
* Functional specifications
* User roles and scenarios
* Technology stack
* Page/module hierarchy
* Test expectations

---

## 🗂️ Recommended Directory Structure

Use the following directory layout as the base for the project:

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
│   ├── CONTRIBUTING.md
│   └── specification.md
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

## 🔁 GitHub Actions Integration

Claude works with GitHub Actions to automate:

* Code review and generation
* Responding to issue and PR comments
* Following documentation and security guidelines

### ⚙️ Setup Instructions

1. Install Claude GitHub App via:

```bash
/install-github-app
```

2. Add `ANTHROPIC_API_KEY` to GitHub Secrets.

3. Create `.github/workflows/claude.yml`:

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

## 🔀 Issue & Branch Management

To enable concurrent development, Claude should follow these best practices:

* For every issue, create a uniquely named branch: `feature/issue-###-slug`
* Work on multiple branches independently and avoid conflicting files
* Each commit should reference its related issue: e.g. `feat: resolves #42`
* Use draft PRs to validate workflows early
* Claude must detect and intelligently resolve merge conflicts

### 🔄 Example Workflow

1. Claude is tagged in issues #101 and #102
2. It creates `feature/issue-101-auth-module` and `feature/issue-102-form-validation`
3. It pushes commits and opens PRs for each branch
4. Each PR is tested, reviewed, and merged independently

---

## 🔐 Security Best Practices

Claude must operate within safe boundaries:

### 🔑 Secrets

* Use GitHub Secrets (e.g., `ANTHROPIC_API_KEY`)
* Never print secrets in logs

### 📏 Scope Restriction

* Limit Claude’s permissions to what is necessary
* Constrain automated changes to defined directories

### 👀 Output Validation

* Human reviewers must check all Claude outputs
* Automated and manual tests are mandatory

### 🛡️ Least Privilege

* Minimize GitHub App permissions
* Avoid enabling Claude for public PRs unless protected

### 🧰 Troubleshooting Tips

If authentication fails:

```bash
gh auth refresh -h github.com -s workflow
```

If terminal input fails (`Raw mode not supported`):

* Avoid interactive scripts in CI
* Use tools like `expect` for input simulation

---

## 🚀 Execution Flow

1. Launch Claude
2. Load this `SETUP.md`
3. Read `docs/specification.md`
4. Scaffold the directory structure
5. Generate documentation
6. Configure GitHub workflows
7. Handle multiple issues in parallel
8. Test, refine, and finalize deliverables

---

## 📄 Deliverables

| Path                           | Description                            |
| ------------------------------ | -------------------------------------- |
| `.claude/CLAUDE.md`            | Core Claude behavior and rules         |
| `docs/README.md`               | Project overview and introduction      |
| `docs/TESTING.md`              | Testing policies and structure         |
| `docs/STRUCTURE.md`            | Architecture and directory explanation |
| `docs/CONTRIBUTING.md`         | Contribution and dev standards         |
| `.github/workflows/claude.yml` | GitHub Actions automation              |
| `docs/specification.md`        | Project specification (reference file) |

---

## 🧠 Final Note to Claude

Claude, please execute this setup thoroughly. Read specifications, interpret intentions, generate assets with precision, and continuously test your output.

You must work across multiple branches, manage parallel tasks, and merge changes gracefully. Your role is not just as an assistant, but as a capable contributor.

Act smart. Iterate often. Build boldly. Let’s make something exceptional together 🐻🚀
