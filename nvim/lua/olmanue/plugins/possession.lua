vim.g.mapleader = " "
local poss = require("nvim-possession")

poss.setup {
  autoload = false,
  autosave = true
}

local keymap = vim.keymap

keymap.set('n', '<leader>sl', poss.list, {})
keymap.set('n', '<leader>sn', poss.new, {})
keymap.set('n', '<leader>su', poss.update, {})
keymap.set('n', '<leader>sd', poss.delete, {})

