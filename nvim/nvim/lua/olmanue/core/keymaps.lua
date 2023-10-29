vim.g.mapleader = " "
local keymap = vim.keymap
local builtin = require('telescope.builtin')

keymap.set('n', '<leader>ff', builtin.find_files, {})
keymap.set('n', '<leader>fg', builtin.live_grep, {})
keymap.set('n', '<leader>fb', builtin.buffers, {})
keymap.set('n', '<leader>fh', builtin.help_tags, {})
keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tp", ":tabn<CR>")
keymap.set("n", "<leader>tn", ":tabp<CR>")
keymap.set('n', '<space>e', vim.diagnostic.open_float)
keymap.set('n', '[d', vim.diagnostic.goto_prev)
keymap.set('n', ']d', vim.diagnostic.goto_next)
keymap.set('n', '<space>q', vim.diagnostic.setloclist)


function copyLink()
  local row,col = unpack(vim.api.nvim_win_get_cursor(0))
  local cwd = vim.fn.getcwd()
  local cmd = 'git rev-parse --show-toplevel';
  local gitHandle = io.popen()
  local gitHandleOutput = gitHandle:read('*a');
  if string.find(gitHandleOutput, "not a git repository") == nil then
  end
  if gitHandleOutput == nil then
    print('not a repository')
    return;
  end
  local reversedDir = gitHandleOutput;
  local startIndex, endIndex = string.find(reversedDir, '/')
  local packageName = string.sub(reversedDir, 0, startIndex)
  if packageName == nil then
    print('Could not locate repo root')
  end
  local codeAmazonRoot = "https://code.amazon.com/packages/"
  local codeAmazonTail = "blobs/mainline"
  print(codeAmazonRoot + packageName + codeAmazonTail)
end

keymap.set('n', '<leader>lc', copyLink)


-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})

keymap.set('n', ':e', ':NvimTreeToggle<CR>')
