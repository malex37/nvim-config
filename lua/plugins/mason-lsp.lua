return {
  "williamboman/mason-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    configure = function()
      require("mason").setup({})
    end,
  },
  opts = {
    ensure_installed = {
      "tsserver",
      "tailwindcss",
      "jsonls",
    },
    automatic_installation = true,
  },
}
