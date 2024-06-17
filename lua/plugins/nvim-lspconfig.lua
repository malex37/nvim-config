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
    --tailwindcss = {},
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
        -- local bemol_dir = vim.fs.find({".bemol"}, { upward = true, type = "directory"})[1]
        -- local wsFolders = {}
        -- if bemol_dir then
        --   local file = io.open(bemol_dir .. "/ws_root_folders", "r")
        --   if file then
        --     for line in file:lines() do
        --       table.insert(wsFolders, line)
        --     end
        --     file:close()
        --   end
        -- end
        --
        -- for _, line in ipairs(wsFolders) do
        --     vim.lsp.buf.add_workspace_folder(line)
        -- end
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
      pylsp = function(_, opts)
        local cmpCap = require("cmp_nvim_lsp")
        require("lspconfig")["pylsp"].setup({
          capabilities = cmpCap,
          server = opts
        })
      end
    },
  },
}
