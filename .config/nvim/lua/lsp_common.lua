-- Shared LSP on_attach + capabilities, used by both the generic server
-- loop (lsp.lua) and rustaceanvim.
local M = {}

-- Advertise nvim-cmp's extra completion capabilities when available.
local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
M.capabilities = ok and cmp_lsp.default_capabilities()
  or vim.lsp.protocol.make_client_capabilities()

function M.on_attach(client, bufnr)
  local function map(keys, fn, desc)
    vim.keymap.set('n', keys, fn, { buffer = bufnr, desc = 'LSP: ' .. desc, silent = true })
  end

  -- Type / docs under cursor and navigation
  map('K', vim.lsp.buf.hover, 'Hover (type/docs)')
  map('gd', vim.lsp.buf.definition, 'Goto definition')
  map('gD', vim.lsp.buf.declaration, 'Goto declaration')
  map('gi', vim.lsp.buf.implementation, 'Goto implementation')
  map('gr', vim.lsp.buf.references, 'References')
  map('<leader>rn', vim.lsp.buf.rename, 'Rename')
  map('<leader>ca', vim.lsp.buf.code_action, 'Code action')

  -- Error / diagnostic info
  map('<leader>e', vim.diagnostic.open_float, 'Line diagnostics')
  map('[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Prev diagnostic')
  map(']d', function() vim.diagnostic.jump({ count = 1, float = true }) end, 'Next diagnostic')

  -- Inline type hints (the "typing" info) when the server supports them
  if client and client:supports_method('textDocument/inlayHint') then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  -- Format Rust on save via rust-analyzer (rustfmt). Buffer-local so it only
  -- runs once the server has attached and the buffer actually supports it.
  if vim.bo[bufnr].filetype == 'rust'
    and client and client:supports_method('textDocument/formatting') then
    local group = vim.api.nvim_create_augroup('LspFormatOnSave.' .. bufnr, { clear = true })
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = group,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 2000 })
      end,
    })
  end
end

return M
