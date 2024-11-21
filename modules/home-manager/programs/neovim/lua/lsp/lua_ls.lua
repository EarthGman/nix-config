local lspc = require("lspconfig")

lspc.lua_ls.setup {
	on_attach = function()
		-- Format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.lua",
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,
}
