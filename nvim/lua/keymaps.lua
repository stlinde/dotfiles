-- NATIVE 
-- Variable to hold commonly used functions
keymap = vim.api.nvim_set_keymap
opt = { noremap = true, silent = true }
local ls = require("luasnip")

-- Setting leader to Space
keymap("", "<Space>", "<Nop>", opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Sourcing init.lua
keymap('n', '<Leader><Leader>r', ':source ~/.config/nvim/init.lua<CR>', opt )

-- Toggle hlsearch
keymap('n', '<Leader>h', ':set hlsearch!<CR>', opt )

-- Open Bibliography File
keymap('n', '<Leader>b', ':vsp<space>/home/slinde/Documents/library.bib<CR>', opt )

-- Better window movement
keymap('n', '<C-h>', '<C-w>h', opt)
keymap('n', '<C-j>', '<C-w>j', opt)
keymap('n', '<C-k>', '<C-w>k', opt)
keymap('n', '<C-l>', '<C-w>l', opt)

-- Better indenting
keymap('v', '<', '<gv', opt)
keymap('v', '>', '>gv', opt)


-- PLUGINS
-- Telescope
keymap('n', '<Leader>ff', ':Telescope find_files<cr>', opt)
keymap('n', '<Leader>fg', ':Telescope live_grep<cr>', opt)
keymap('n', '<Leader>fb', ':Telescope buffers<cr>', opt)
keymap('n', '<Leader>fh', ':Telescope help_tags<cr>', opt)
keymap('n', '<Leader>fl', ':Telescope file_browser<cr>', opt)
keymap('n', '<Leader>fm', ':Telescope media_files<cr>', opt)

-- PDF Selector
keymap('n', '<Leader>fp', ':lua require("telescope_conf").pdf_selector()<CR>', opt)

-- Notetaking
keymap('n', '<Leader>fn', ':lua require("telescope_conf").note_finder()<CR>', opt)

-- LuaSnip

-- This will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

-- This always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

