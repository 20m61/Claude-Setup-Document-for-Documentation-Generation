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

### 📝 Specification Template Example

```markdown
# Project Specification

## 🎯 Project Goals
- Primary objective: [Brief description]
- Secondary objectives: [List]

## 📋 Functional Requirements
### Core Features
1. Feature A: [Description]
2. Feature B: [Description]

### User Stories
- As a [role], I want to [action] so that [benefit]

## 👥 User Roles
- Admin: [Permissions and responsibilities]
- User: [Permissions and responsibilities]

## 🛠️ Technology Stack
- Frontend: React 18.x, TypeScript 5.x
- Backend: Node.js 20.x, Express 4.x
- Database: PostgreSQL 15.x
- Testing: Jest, React Testing Library

## 📊 Success Metrics
- Performance: [Specific metrics]
- User engagement: [Specific metrics]
```

---

## 📦 Version Requirements

### Minimum Versions
```json
{
  "engines": {
    "node": ">=20.0.0",
    "npm": ">=10.0.0"
  }
}
```

### Recommended Versions
- Node.js: 20.11.0 (LTS)
- npm: 10.2.4
- TypeScript: 5.3.x
- React: 18.2.x (if applicable)
- Python: 3.11.x (if applicable)

---

## 🗂️ Recommended Directory Structure

Use the following directory layout as the base for the project:

```
my-project/
├── .claude/
│   ├── CLAUDE.md
│   ├── goals.md
│   ├── mistakes.md
│   ├── prompts.md
│   ├── mcp_config.json
│   └── mcp_config.json.example
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
│   ├── setup-mcp.sh
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
├── .env.example
├── .env.local
└── CLAUDE.md
```

---

## 🌍 Environment Variables Management

### Setup

1. Create `.env.example` with all required variables (without values):
```bash
# API Keys
ANTHROPIC_API_KEY=
DATABASE_URL=

# Application Config
NODE_ENV=
PORT=
LOG_LEVEL=
```

2. Copy to `.env.local` for local development:
```bash
cp .env.example .env.local
```

3. Add `.env.local` to `.gitignore`

### Environment-Specific Configs

```
config/
├── default.json     # Shared settings
├── development.json # Dev overrides
├── staging.json     # Staging overrides
└── production.json  # Prod overrides
```

---

## 📚 Dependency Management

### Security Practices

1. **Lock Files**: Always commit `package-lock.json` or `yarn.lock`

2. **Security Audits**: Run regularly
```bash
npm audit
npm audit fix --audit-level=moderate
```

3. **Update Strategy**:
```bash
# Check outdated packages
npm outdated

# Update minor/patch versions
npm update

# Update major versions carefully
npm install package@latest
```

4. **Dependency Review**: Add to `package.json`:
```json
{
  "scripts": {
    "audit": "npm audit --audit-level=moderate",
    "check-updates": "npx npm-check-updates"
  }
}
```

---

## 🧪 Test Strategy

### Test Structure
```
tests/
├── unit/           # Fast, isolated tests
├── integration/    # Component interaction tests
├── e2e/           # End-to-end user flows
└── fixtures/      # Test data and mocks
```

### Coverage Goals
- Unit Tests: 80% coverage minimum
- Integration Tests: Critical paths covered
- E2E Tests: Main user journeys

### Test Scripts
```json
{
  "scripts": {
    "test": "jest",
    "test:unit": "jest tests/unit",
    "test:integration": "jest tests/integration",
    "test:e2e": "playwright test",
    "test:coverage": "jest --coverage",
    "test:watch": "jest --watch"
  }
}
```

### Test Principles
1. **AAA Pattern**: Arrange, Act, Assert
2. **Single Responsibility**: One test, one behavior
3. **Descriptive Names**: `should_[expectedBehavior]_when_[condition]`
4. **No Test Interdependence**: Tests run in any order

---

## 🚨 Error Handling Guidelines

### Error Categories

1. **Operational Errors**: Expected failures
   - Network timeouts
   - Invalid user input
   - Database conflicts

2. **Programming Errors**: Bugs
   - Type errors
   - Null references
   - Logic errors

### Error Handling Patterns

```typescript
// Custom error classes
class ApplicationError extends Error {
  constructor(
    public message: string,
    public code: string,
    public statusCode: number,
    public isOperational: boolean = true
  ) {
    super(message);
    Error.captureStackTrace(this, this.constructor);
  }
}

// Global error handler
app.use((error: Error, req: Request, res: Response, next: NextFunction) => {
  if (error instanceof ApplicationError && error.isOperational) {
    // Log and return user-friendly error
    logger.error(error);
    return res.status(error.statusCode).json({
      error: {
        code: error.code,
        message: error.message
      }
    });
  }
  
  // Programming errors - log and return generic message
  logger.fatal(error);
  return res.status(500).json({
    error: {
      code: 'INTERNAL_ERROR',
      message: 'An unexpected error occurred'
    }
  });
});
```

### Claude Error Recovery

When Claude encounters errors:

1. **Log the error context**
2. **Attempt recovery** if possible
3. **Report to user** with actionable steps
4. **Update `mistakes.md`** with learnings

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

## 🔧 MCP (Model Context Protocol) Setup

### Required MCP Tools

Claude can leverage MCP tools to enhance its capabilities. Install and configure the following:

#### 1. **File System MCP**
Provides enhanced file operations beyond basic read/write.

```bash
npm install -g @modelcontextprotocol/server-filesystem
```

Configuration in `claude_mcp_config.json`:
```json
{
  "fileSystemMCP": {
    "command": "mcp-server-filesystem",
    "args": ["--allowed-directories", "/workspaces/", "/tmp/"]
  }
}
```

#### 2. **Git MCP**
Enhanced Git operations and repository management.

```bash
npm install -g @modelcontextprotocol/server-git
```

Configuration:
```json
{
  "gitMCP": {
    "command": "mcp-server-git",
    "args": ["--repo-path", "."]
  }
}
```

#### 3. **Database MCP** (if applicable)
For projects with database interactions.

```bash
npm install -g @modelcontextprotocol/server-postgres
# or
npm install -g @modelcontextprotocol/server-sqlite
```

#### 4. **Web Search MCP**
For accessing up-to-date information.

```bash
npm install -g @modelcontextprotocol/server-websearch
```

#### 5. **IDE Integration MCP**
Already available in Claude Code:
- `mcp__ide__getDiagnostics` - Get language diagnostics from VS Code
- `mcp__ide__executeCode` - Execute code in Jupyter notebooks

### MCP Configuration File

Create `.claude/mcp_config.json`:

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "mcp-server-filesystem",
      "args": ["--allowed-directories", "./src", "./tests", "./docs"],
      "description": "File system operations"
    },
    "git": {
      "command": "mcp-server-git",
      "args": ["--repo-path", "."],
      "description": "Git operations"
    },
    "memory": {
      "command": "mcp-server-memory",
      "args": [],
      "description": "Persistent memory across sessions"
    }
  },
  "globalOptions": {
    "timeout": 30000,
    "retryAttempts": 3
  }
}
```

### Usage Guidelines

1. **File Operations**: Use MCP filesystem tools for batch operations
2. **Git Integration**: Use MCP git tools for complex branch management
3. **Memory Persistence**: Use memory MCP to maintain context across sessions
4. **IDE Integration**: Leverage VS Code diagnostics for real-time error detection

### Installation Script

Add to `scripts/setup-mcp.sh`:

```bash
#!/bin/bash

echo "Installing MCP tools..."

# Core MCP tools
npm install -g @modelcontextprotocol/server-filesystem
npm install -g @modelcontextprotocol/server-git
npm install -g @modelcontextprotocol/server-memory

# Optional tools based on project needs
if [ -f "package.json" ] && grep -q "postgres" package.json; then
  npm install -g @modelcontextprotocol/server-postgres
fi

# Create MCP config directory
mkdir -p .claude
cp .claude/mcp_config.json.example .claude/mcp_config.json

echo "MCP tools installed successfully!"
```

---

## 🚀 CI/CD Pipeline

### Pipeline Stages

1. **Build Stage**
```yaml
build:
  runs-on: ubuntu-latest
  steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-node@v4
      with:
        node-version: '20'
        cache: 'npm'
    - run: npm ci
    - run: npm run build
```

2. **Test Stage**
```yaml
test:
  needs: build
  strategy:
    matrix:
      test-type: [unit, integration, e2e]
  steps:
    - run: npm run test:${{ matrix.test-type }}
    - uses: actions/upload-artifact@v4
      if: failure()
      with:
        name: test-results-${{ matrix.test-type }}
        path: test-results/
```

3. **Deploy Stage**
```yaml
deploy:
  needs: [build, test]
  if: github.ref == 'refs/heads/main'
  steps:
    - run: npm run deploy:${{ github.event_name == 'release' && 'prod' || 'staging' }}
```

### Quality Gates

- ✅ All tests pass
- ✅ Code coverage > 80%
- ✅ No security vulnerabilities
- ✅ Linting passes
- ✅ Type checking passes

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
4. Install MCP tools via `scripts/setup-mcp.sh`
5. Configure MCP settings in `.claude/mcp_config.json`
6. Scaffold the directory structure
7. Generate documentation
8. Configure GitHub workflows
9. Handle multiple issues in parallel
10. Test, refine, and finalize deliverables

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
| `.claude/mcp_config.json`      | MCP tools configuration                |
| `scripts/setup-mcp.sh`         | MCP installation script                |

---

## 🧠 Final Note to Claude

Claude, please execute this setup thoroughly. Read specifications, interpret intentions, generate assets with precision, and continuously test your output.

You must work across multiple branches, manage parallel tasks, and merge changes gracefully. Your role is not just as an assistant, but as a capable contributor.

Act smart. Iterate often. Build boldly. Let’s make something exceptional together 🐻🚀
