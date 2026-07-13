local common = require('lsp_common')

-- Show error/warn text inline plus signs in the gutter.
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = true },
})

-- Walk up from `start_path` looking for a .venv directory.
-- Returns the venv's python path, or nil if not found.
local function find_venv_python(start_path)
  local path = start_path
  while path and path ~= '/' do
    local venv = path .. '/.venv'
    if vim.fn.isdirectory(venv) == 1 then
      local python = venv .. '/bin/python'
      if vim.fn.executable(python) == 1 then
        return python, path
      end
    end
    path = vim.fn.fnamemodify(path, ':h')
  end
  return nil, nil
end

-- rust_analyzer is intentionally NOT here: rustaceanvim owns it (ft = "rust").
-- pyright is configured separately below to support uv/.venv auto-detection.
local servers = { 'hls', 'html', 'jdtls', 'jsonls', 'sourcekit', 'ts_ls', 'yamlls' }
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = common.on_attach,
    capabilities = common.capabilities,
  })
  vim.lsp.enable(lsp)
end

-- Pyright: auto-detect .venv (created by uv, venv, virtualenv, etc.)
-- so go-to-definition, hover, and completions resolve project dependencies.
-- Full config is needed because there is no nvim-lspconfig or built-in
-- runtime config providing cmd/filetypes/root_markers for pyright.
local python, venv_root = find_venv_python(vim.fn.getcwd())
local python_settings = {}
if python and venv_root then
  python_settings.pythonPath = python
  python_settings.venvPath = venv_root
  python_settings.venv = '.venv'
end

vim.lsp.config('pyright', {
  cmd = { 'pyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git' },
  on_attach = common.on_attach,
  capabilities = common.capabilities,
  settings = {
    python = python_settings,
  },
})
vim.lsp.enable('pyright')
