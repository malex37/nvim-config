local call = vim.call

local Plug = vim.fn['plug#']

call 'plug#begin'
  Plug 'Mofiqul/vscode.nvim'
  Plug 'williamboman/mason.nvim'
  Plug 'mason-org/mason-registry'
  Plug 'williamboman/mason-lspconfig'
  Plug 'neovim/nvim-lspconfig'
  Plug ('ibhagwan/fzf-lua', { branch = 'main' })
  Plug 'gennaro-tedesco/nvim-possession'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'nvim-lua/plenary.nvim'
  Plug ('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
  Plug ('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' });
  Plug ('nvim-telescope/telescope.nvim', { branch = '0.1.x' })
  Plug 'numToStr/Comment.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-tree/nvim-tree.lua'
  Plug 'jose-elias-alvarez/typescript.nvim'
  Plug ('nvimdev/lspsaga.nvim', { branch = 'main' })
--  Plug 'windwp/nvim-autopairs'
--  Plug 'f-person/git-blame.nvim'
--  Plug 'tanvirtin/vgit.nvim'
--  Plug 'rhysd/git-messenger.vim'
  Plug 'lewis6991/gitsigns.nvim'
call 'plug#end'

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "tsserver", "clangd", "volar", "tailwindcss", "lua_ls", "eslint", "perlnavigator", "smithy_ls"},
  automatic_installation = true 
}
require("nvim-treesitter.configs").setup{highlight={enable = true},indent={enable = true},ensure_installed={"vue", "typescript", "javascript", "json", "html", "lua", "markdown_inline", "smithy"},autotag={enable=true}}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.typescript.filetype_to_parsername = {
  "typescript",
}
parser_config.perl.filetype_to_parsername = {
  "perl"
}

local cmpCap = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require("lspconfig")
local devicons = require("nvim-web-devicons")
local cmp = require("cmp")


--local cmp_autopairs = require('nvim-autopairs.completion.cmp')
--local cmp = require('cmp')
-- cmp.event:on(
--  'confirm_done',
--  cmp_autopairs.on_confirm_done()
--)

require("lspsaga").setup {}

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr } 
  vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
  vim.keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
  vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
  vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
  vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
  vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
  vim.keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
  vim.keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
  vim.keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
  vim.keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
  vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

  -- typescript specific keymaps (e.g. rename file and update imports)
  if client.name == "tsserver" then
    vim.keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
    vim.keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports 
    vim.keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables
  end
  
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

cmp.setup {
  snippet = { 
    expand= function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Tab"] = cmp.mapping.select_prev_item(), -- previous suggestion
    ["<C-t"] = cmp.mapping.select_next_item(), -- next suggestion
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Escape>"] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
    { name = "vsnip" }
  })
}

require("olmanue.plugins.telescope-setup")

require("olmanue.plugins.comment")
require("olmanue.plugins.devicons")
require("olmanue.plugins.nvim-tree")
require("olmanue.plugins.possession")
-- require("olmanue.plugins.git-blame")
require("olmanue.plugins.gitsigns")
vim.o.background = 'light'
local colorSchem = require("vscode.colors").get_colors()
local vscode = require('vscode')
vscode.setup({
  transparent = true,
  disable_nvimtree_bg = true,
})

--require('nvim-autopairs').setup {}

vscode.load()
