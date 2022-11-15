local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local servers = { "gopls", "sumneko_lua", "pyright", "ansiblels", "terraformls", "tflint", "yamlls" }

mason_lspconfig.setup {
	ensure_installed = servers
}

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	--if has_custom_opts then
	-- 	opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
	--end
	--mason_lspconfig[server].setup(opts)
end

