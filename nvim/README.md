# Neovim Configuration

A modular and well-organized Neovim configuration using lazy.nvim plugin manager with a focus on performance and maintainability.

## Structure

```
nvim/
├── init.lua                    # Main entry point
├── lazy-lock.json             # Plugin version lockfile
├── README.md                  # This documentation
└── lua/
    └── custom/
        ├── autocmds.lua       # Auto-commands
        ├── commands.lua       # Custom commands
        ├── keymaps.lua        # Key mappings
        ├── options.lua        # Vim options
        ├── plugins.lua        # Plugin definitions
        ├── configs/           # Plugin configurations
        │   ├── blink.lua      # Blink completion config
        │   ├── debugprint.lua # Debug print config
        │   ├── gitsigns.lua   # Git signs config
        │   ├── grapple.lua    # File marking config
        │   ├── lsp.lua        # LSP configuration
        │   ├── lualine.lua    # Status line config
        │   ├── luasnip.lua    # Snippet config
        │   ├── mason.lua      # LSP installer config
        │   ├── oil.lua        # File manager config
        │   ├── telescope.lua  # Fuzzy finder config
        │   └── treesitter.lua # Syntax highlighting config
        ├── snippets/          # Custom snippets
        │   ├── init.lua       # Snippet loader
        │   ├── go.lua         # Go snippets
        │   └── python.lua     # Python snippets
        └── utils/             # Utility functions
            ├── init.lua       # Utils loader
            └── quickfix.lua   # Quickfix utilities
```

## Plugin Categories

### Core & Essential
- **vim-sleuth**: Auto-detect indentation
- **which-key**: Keybind helper
- **gruvbox**: Color theme

### Editor Enhancement
- **Comment.nvim**: Smart commenting with `gc`
- **oil.nvim**: File manager with buffer-like editing

### Completion & Snippets
- **blink.cmp**: Fast completion engine with Rust backend
- **LuaSnip**: Snippet engine with custom snippets
- **lazydev.nvim**: Lua development enhancements

### Git Integration
- **gitsigns.nvim**: Git status in sign column
- **vim-fugitive**: Comprehensive Git integration
- **openingh.nvim**: Open files in GitHub web interface

### LSP & Development
- **nvim-lspconfig**: LSP client configurations
- **mason.nvim**: LSP server installer
- **fidget.nvim**: LSP progress notifications

### Search & Navigation
- **telescope.nvim**: Fuzzy finder for files, buffers, etc.
- **telescope-ui-select**: Use Telescope for vim.ui.select
- **grapple.nvim**: File marking and quick navigation

### Syntax & Language
- **nvim-treesitter**: Advanced syntax highlighting and text objects
- **markdown-preview.nvim**: Live markdown preview in browser

### Debug & Tools
- **debugprint.nvim**: Insert debug print statements

### UI Components
- **lualine.nvim**: Customizable status line

## Key Features

### Plugin Management
- **lazy.nvim**: Fast startup with lazy loading
- **Change detection disabled**: No reload notifications
- **Automatic config loading**: All files in `configs/` are auto-loaded

### Modular Architecture
- **Separation of concerns**: Plugin definitions separate from configurations
- **Categorized plugins**: Logical grouping for easy maintenance
- **Utility modules**: Reusable functions in `utils/` directory

### Custom Utilities
- **Quickfix tools**: Functions for reorganizing and working with quickfix lists
- **Custom snippets**: Language-specific code snippets for Go and Python

## Configuration Loading

The configuration loads in this order:
1. **Plugin manager setup** (lazy.nvim)
2. **Core settings**: options, autocmds, snippets, keymaps, commands
3. **Plugin configurations**: All files in `lua/custom/configs/` are auto-loaded

## Key Mappings

### Leader Key
- Leader key is set to `<Space>`

### Grapple (File Marking)
- `<leader>m`: Toggle file mark
- `<leader>M`: Open marks window
- `<leader>n`: Next marked file
- `<leader>p`: Previous marked file


### Debug Print
- `<leader>dp`: Insert plain debug print below
- `<leader>dP`: Insert plain debug print above
- `<leader>dv`: Insert variable debug print below
- `<leader>dV`: Insert variable debug print above

## Customization

### Adding Plugins
1. Add plugin spec to appropriate category in `lua/custom/plugins.lua`
2. Create config file in `lua/custom/configs/` if needed
3. Plugin configs are automatically loaded

### Adding Snippets
1. Create or edit files in `lua/custom/snippets/`
2. Snippets are automatically loaded via `init.lua`

### Adding Utilities
1. Create files in `lua/custom/utils/`
2. Export functions via `lua/custom/utils/init.lua`
3. Access via `require("custom.utils")`

## Performance

- **Lazy loading**: Most plugins load on demand
- **Fast startup**: Optimized for quick Neovim startup times  
- **Change detection disabled**: No file watching overhead
- **Modular loading**: Only load what's needed when needed

## Maintenance

- **Plugin versions locked**: `lazy-lock.json` ensures reproducible installs
- **Clear organization**: Easy to find and modify specific functionality
- **Automatic loading**: New config files are picked up automatically
- **Documentation**: This README explains the structure and usage