return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    ensure_installed = { "vue", "typescript", "javascript", "json", "html", "lua", "markdown_inline", "c", "cpp" },
    autotag = { enable = true },
  },
}
