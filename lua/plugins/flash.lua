return {
  "folke/flash.nvim",
  event = "VeryLazy",
  vscode = true,
  opts = {},
  keys = {
    {
      "S",
      mode = { "n" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
  },
}
