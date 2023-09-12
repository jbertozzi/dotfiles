local servers = {"gopls", "lua_ls", "pyright", "ansiblels", "terraformls", "tflint", "yamlls"}

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers})

