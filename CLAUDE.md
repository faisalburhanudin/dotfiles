# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Setup and Synchronization

This is a personal dotfiles repository that manages configuration files for various development tools. The main setup command is:

```bash
./sync.sh
```

This script creates symbolic links from the dotfiles to their expected locations in the home directory and system config folders.

## Repository Structure

- **nvim/**: Complete Neovim configuration with lazy.nvim plugin manager
  - `init.lua`: Main configuration entry point
  - `lua/custom/`: Custom configuration modules (options, keymaps, autocmds, plugins, configs)
  - `lua/custom/snippets/`: Language-specific code snippets
- **claude/commands/**: Custom Claude Code command definitions
  - `acp.md`: Git add-commit-push workflow command
  - `pr.md`: GitHub pull request creation command
- Configuration files: `gitconfig`, `gitignore`, `tmux.conf`, `zshrc`, `alacritty.yml`, `skhdrc`, `lazy-config.yml`, `typos.toml`

## Neovim Architecture

The Neovim configuration uses a modular approach with comprehensive documentation:
- **Plugin Manager**: lazy.nvim with auto-installation and disabled change detection
- **Plugin Loading**: Categorized plugins defined in `lua/custom/plugins.lua` 
- **Config Loading**: Automatic loading of all files in `lua/custom/configs/` directory
- **Utility Modules**: Reusable functions in `lua/custom/utils/` directory
- **Key Features**: LSP with Mason, Telescope fuzzy finder, Treesitter, Grapple file marking, Oil file manager, blink.cmp completion
- **Documentation**: Complete configuration documentation available in `nvim/README.md`

## Common Commands

**Sync dotfiles to system:**
```bash
./sync.sh
```

**Neovim plugin management:**
- Plugins are automatically installed via lazy.nvim on first run
- Plugin updates happen automatically or can be triggered with `:Lazy update`

## Custom Claude Commands

This repository includes custom Claude Code commands:
- **acp**: Complete git workflow (add, commit, push) with safety checks
- **pr**: GitHub pull request creation with proper templating

## File Linking Strategy

All configuration files are symlinked from this repository to their target locations, allowing version control of all dotfiles while maintaining standard file locations expected by applications.