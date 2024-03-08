return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  event = "LazyFile",
  ---@class PluginLspOpts
  opts = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    servers = {
      tailwindcss = {},
      tsserver = {},
    },
    setup = {
      tsserver = function(_, opts)
        vim.g.autoformat = false
        require("lspconfig")["tsserver"].setup({
          server = opts,
        })
        return true
      end,
    },
  },
}
