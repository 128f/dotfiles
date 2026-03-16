local servers = { 'hls', 'html', 'jdtls', 'jsonls', 'pyright', 'rust_analyzer', 'sourcekit', 'ts_ls', 'yamlls' }
for _, lsp in ipairs(servers) do
	vim.lsp.config(lsp, { on_attach = on_attach })
	vim.lsp.enable(lsp)
end
