return {
  "williamboman/mason-lspconfig",
  dependencies = {
    "mfussenegger/nvim-jdtls"
  },
  handlers = {
    function(server_name)
      ---@diagnostic disable-next-line: undefined-global
      local server = servers[server_name] or {}
      require("lspconfig")[server_name].setup({
        cmd = server.cmd,
        settings = server.settings,
        filetypes = server.filetypes,
        ---@diagnostic disable-next-line: undefined-global
        capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
      })
    end,
    jdtls = function()
      ---@diagnostic disable-next-line: missing-fields
      require("lspconfig").jdtls.setup({
        on_attach = function()
          local bemol_dir = vim.fs.find({ ".bemol" }, { upward = true, type = "directory" })[1]
          local ws_folders_lsp = {}
          if bemol_dir then
            local file = io.open(bemol_dir .. "/ws_root_folders", "r")
            if file then
              for line in file:lines() do
                table.insert(ws_folders_lsp, line)
              end
              file:close()
            end
          end
          for _, line in ipairs(ws_folders_lsp) do
            vim.lsp.buf.add_workspace_folder(line)
          end
        end,
        cmd = {
          "jdtls",
          "--jvm-arg=-javaagent:" .. require("mason-registry").get_package("jdtls"):get_install_path() .. "/lombok.jar",
        },
      })
    end,
  },
}
