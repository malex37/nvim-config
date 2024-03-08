return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find fies" },
  },
  opts = {
    defaults = {
      file_ignore_patterns = {
        "^node_modules/",
        "^out/",
        "^doc/",
      },
    },
  },
}
