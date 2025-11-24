# Theme

The default theme is `default`(refer to `vim.g.default_theme`)

Each time the theme is modified, it will be saved in `vim.fn.stdpath('config')/.nvim-theme`, and the next time it will be loaded

## Commands & Keybindings

| Command               | Description                                                                             |
| --------------------- | --------------------------------------------------------------------------------------- |
| `:colorscheme`        | Show the current colorscheme                                                            |
| `:ListColorscheme`    | List all the available colorschemes                                                     |
| `:colorscheme <name>` | Change the colorscheme to specified theme                                               |
| `<C-k><C-p>`          | use the shortcut to open `telescope`, and then select `colorscheme` to switch the theme |

## Completion Menu

Beyond the global colorscheme, the autocompletion menu (`nvim-cmp`) has been highly customized to provide a unique and aesthetically pleasing experience. This includes:

- **Custom Icons**: Icons are tailored for different completion item kinds (functions, variables, etc.).
- **Detailed Layout**: The menu layout is formatted to be clean and readable, providing a better visual distinction between items.
- **Syntax Highlighting**: The menu items are highlighted to match the code syntax.

