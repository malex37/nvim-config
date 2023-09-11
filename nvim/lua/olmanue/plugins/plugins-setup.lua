local call = vim.call

local Plug = vim.fn['plug#']

call 'plug#begin'
  Plug 'Mofiqul/vscode.nvim'
  Plug 'williamboman/mason.nvim'
  Plug 'mason-org/mason-registry'
  Plug 'williamboman/mason-lspconfig'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'nvim-lua/plenary.nvim'
  Plug ('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
  Plug ('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' });
  Plug ('nvim-telescope/telescope.nvim', { branch = '0.1.x' })
  Plug 'numToStr/Comment.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'jose-elias-alvarez/typescript.nvim'
  Plug ('nvimdev/lspsaga.nvim', { branch = 'main' })
  Plug 'f-person/git-blame.nvim'
  Plug 'tanvirtin/vgit.nvim'
  Plug 'rhysd/git-messenger.vim'
  Plug ('l3mon4d3/luasnip', {  ['do'] = 'make install_jsregexp' })
call 'plug#end'

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "tsserver", "clangd", "volar", "tailwindcss", "lua_ls" },
  automatic_installation = true 
}
require("nvim-treesitter.configs").setup{
  highlight={
    enable = true
  },
  indent={
    enable = true
  },
  ensure_installed={
    "vue",
    "typescript",
    "javascript",
    "json",
    "html",
    "lua",
    "markdown_inline",
    "c",
    "vim",
    "vimdoc",
    "query",
    "cpp"
  },
  autotag={
    enable=true
  }
}


require("vgit").setup()

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.typescript.filetype_to_parsername = {
  "typescript",
}
--parser_config.

local cmpCap = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")
local devicons = require("nvim-web-devicons")

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr } 
  keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
    keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports 
    keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables
  end


  vim.api.nvim_create_autocmd("CursordHold", {
    buffer = bufnr,
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = 'rounded',
      source = 'always',
      prefix = ' ',
      scope = 'cursor',
    }
    vim.diagnostic.open_float(nil, opts)
  end
  })
  
end

lspconfig["pyright"].setup {}
lspconfig["volar"].setup {
	capabilities = cmpCap,
  	on_attach = on_attach
}

lspconfig["tsserver"].setup {
	capabilities = cmpCap,
  	on_attach = on_attach
}
lspconfig["clangd"].setup {
  capabilities = cmpCap,
  on_attach = on_attach
}

local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ["<C-Tab"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-t"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Escape>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "path" },
    { name = "treesitter" },
  }),
  snippet = {
    expand = function(args) require('luasnip').lsp_expand(args.body) end
  },
}

require("olmanue.plugins.telescope-setup")

require("olmanue.plugins.comment")
require("olmanue.plugins.devicons")
require("olmanue.plugins.nvim-tree")
require("olmanue.plugins.git-blame")

vim.o.background = 'light'
local colorSchem = require("vscode.colors").get_colors()
local vscode = require('vscode')
vscode.setup({
  transparent = true,
  disable_nvimtree_bg = true,
})

vscode.load()
