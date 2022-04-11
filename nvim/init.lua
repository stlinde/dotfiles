-- Autocompile when changes are made in plugins.lua
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

-- Packer config.
-- Automatically bootstraps and installs packer.
require('plugins')

-- Keymapping config
require('keymaps')

-- General settings
require('settings')

-- Treesitter
require('treesitter')

-- Colorscheme
require('colorscheme')

-- LSP
require('language-servers')

-- Completion
require('completion')

-- Telescope
require('telescope_conf')

-- Lualine
require('lualine_conf')

-- VimTeX
require('vimtex_conf')

-- LuaSnip
require('snippets')

