return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    { "folke/neodev.nvim", opts = {} },
  },
  event = "LazyFile",
  servers = {
    jdtls = {},
    -- tsserver = {},
    tailwindcss = {},
    -- stylua = {},
    lua_ls = {},
    clangd = {
      keys = {
        { "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
      },
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
          "Makefile",
          "configure.ac",
          "configure.in",
          "config.h.in",
          "meson.build",
          "meson_options.txt",
          "build.ninja"
        )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(fname) or require(
          "lspconfig.util"
        ).find_git_ancestor(fname)
      end,
      capabilities = {
        offsetEncoding = { "utf-16" },
      },
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
    },
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
      -- lua_ls = function(_, opts)
      --   vim.g.autoformat = true
      --   local cmpCap = require("cmp_nvim_lsp")
      --   require("lspconfig")["lua_ls"].setup({
      --     server = opts,
      --     capabilites = cmpCap,
      --   })
      -- end,
      jdtls = function()
        return true
      end,
      clangd = function(_, opts)
        local clangd_ext_opts = LazyVim.opts("clangd_extensions.nvim")
        require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
        return false
      end,
      smithy_ls = function(_, opts)
        local cmpCap = require("cmp_nvim_lsp")
        require("lspconfig")["smithy_ls"].setup({
          server = opts,
          capabilities = cmpCap,
        })
      end,
    },
  },
}
