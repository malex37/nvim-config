-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.relativenumber = false
opt.number = true
opt.rtp = opt.rtp + "/home/linuxbrew/.linuxbrew/opt/fzf"
--vim.lsp.set_log_level("debug")
