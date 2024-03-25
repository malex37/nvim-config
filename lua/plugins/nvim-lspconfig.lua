return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  event = "LazyFile",
  servers = {
    jdtls = {},
    -- tsserver = {},
    tailwindcss = {},
    -- stylua = {},
    -- lua_ls = {},
  },
  ---@class PluginLspOpts
  opts = {
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
    setup = {
      tsserver = function(_, opts)
        vim.g.autoformat = false
        local cmpCap = require("cmp_nvim_lsp").default_capabilities()
        require("lspconfig")["tsserver"].setup({
          server = opts,
          capabilities = cmpCap,
        })
        return true
      end,
      stylua = function(_, opts)
        vim.g.autoformat = true
        local cmpCap = require("cmp_nvim_lsp")
        require("lspconfig")["stylua"].setup({
          server = opts,
          capabilites = cmpCap,
        })
      end,
      lua_ls = function(_, opts)
        vim.g.autoformat = true
        local cmpCap = require("cmp_nvim_lsp")
        require("lspconfig")["lua_ls"].setup({
          server = opts,
          capabilites = cmpCap,
        })
      end,
      jdtls = function()
        return true
      end,
    },
  },
}
