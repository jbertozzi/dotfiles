local status_ok, mason = pcall(require, "mason")
if not status_ok then
	return
end

mason.setup()

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

mason_lspconfig.setup()

local servers = { "gopls", "lua_ls", "pyright", "ansiblels", "terraformls", "tflint", "yamlls" }

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
  require("lspconfig")[server].setup(opts)
end

-- mason_lspconfig.setup_handlers {
--   -- The first entry (without a key) will be the default handler
--   -- and will be called for each installed server that doesn't have
--   -- a dedicated handler.
--   function (server_name) -- default handler (optional)
--     require("lspconfig")[server_name].setup {}
--   end
-- }
