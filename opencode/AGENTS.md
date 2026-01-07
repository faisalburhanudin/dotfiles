# AGENTS.md

## Repository Overview

OpenCode configuration directory for AI coding agents and MCP servers. Contains opencode tool config, custom agent definitions, and dependencies.

## Setup Commands

```bash
npm install
```

No build process required - this is a configuration directory.

## Build/Lint/Test Commands

**No tests** - Configuration directory without test suite.

**Validation:**
- `opencode.json` validated against https://opencode.ai/config.json
- Agent frontmatter requires: description, mode, model, tools, permission

## File Structure

**Configuration:**
- `opencode.json` - Main opencode tool configuration
- `package.json` - Node.js dependencies
- `.gitignore` - Git ignore rules

**Agents:**
- `agent/` - Directory containing custom agent definitions
- `agent/git-commit.md` - Git commit specialist agent

**Generated:**
- `node_modules/` - Installed dependencies (gitignored)
- `bun.lock` - Lockfile for dependency resolution

## Code Style Guidelines

### Agent Definition Files (agent/*.md)

**Frontmatter Format:**
Use YAML frontmatter with: description, mode, model, tools, permission.

```yaml
---
description: Brief description
mode: subagent
model: opencode/model-name
tools:
  bash: true
permission:
  bash: allow
---
```

**Agent Instructions:**
- Start with a clear role definition
- Use numbered lists for procedures
- Use bold for important steps
- Include code examples in fenced code blocks

### opencode.json Configuration

**Schema:** Follow https://opencode.ai/config.json

**Permission Levels:** `ask` (confirm), `allow` (auto), `deny` (block)

**TUI Settings:**
- `scroll_speed` - Lines to scroll (default: 3)
- `scroll_acceleration.enabled` - Enable acceleration

**MCP Configuration:**
- `type` - "local" or "remote"
- `command` - Command arguments array
- `environment` - Use `{env:VAR_NAME}` pattern
- `enabled` - Boolean flag

### package.json

**Dependencies:**
- Use specific version ranges (e.g., "1.1.4")
- Only include required dependencies
- Use npm for package management

## Common Patterns

**Adding a New MCP Server:**
1. Add server configuration to `opencode.json` under `mcp` section
2. Set `enabled: true` to activate
3. Use `{env:VAR_NAME}` for environment variables
4. Use `npx -y` for running packages without installation

**Creating a New Agent:**
1. Create `.md` file in `agent/` directory
2. Add YAML frontmatter with required fields
3. Write clear, step-by-step instructions
4. Use bold formatting for emphasis
5. Include code examples in code blocks

**Git Workflow:**
- Use `agent/git-commit.md` agent for creating commits
- Commit messages follow imperative mood
- Subject lines under 50 characters
- Body explains "why" not "what"

## Security

- Never commit secrets or API keys
- Use `{env:VAR_NAME}` pattern for environment variables in opencode.json
- Set sensitive tool permissions to `ask` instead of `allow`
- Review all MCP server configurations before committing
- Keep `.gitignore` up to date with generated files

## Naming Conventions

**Agent Files:** `kebab-case.md` (e.g., `git-commit.md`)
**MCP Server Names:** `kebab-case` in opencode.json
**Environment Variables:** `UPPER_SNAKE_CASE`
