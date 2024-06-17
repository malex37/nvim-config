-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
opt.relativenumber = false
opt.number = true
opt.rtp = opt.rtp + "/home/linuxbrew/.linuxbrew/opt/fzf"
--vim.lsp.set_log_level("debug")
if vim.g.neovide then
  local config_pattern = {"Config"}
  local config_path = vim.fs.dirname(vim.fs.find(config_pattern, { upward = true})[1])
  local other_path = { ".git", ".gitignore", "package.json" }
  if config_path then
    vim.g.titlestring = string.match(config_path, "[^/]*$")
  elseif other_path then
    -- print "It's another kind of project"
    vim.g.titlestring = other_path
  else
    vim.g.titlestring = "Neoviiiiiiide"
  end
  vim.o.title = true
  vim.g.neovide_remember_window_size = true
end
