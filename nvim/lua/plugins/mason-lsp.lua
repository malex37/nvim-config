return {
  "williamboman/mason-lspconfig",
  opts = {
    ensure_installed = { "tsserver", "volar", "tailwindcss", "lua_ls", "perlnavigator", "ltex", "powershell_es" },
    automatic_installation = true,
  },
}
