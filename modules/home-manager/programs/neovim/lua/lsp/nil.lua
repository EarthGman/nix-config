local lspc = require("lspconfig")

lspc.nil_ls.setup({
	on_attach = function()
		-- Format on save for nix files
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.nix",
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})
	end,

	settings = {
		['nil'] = {
			formatting = {
				command = { "nixpkgs-fmt" },
			},
			nix = {
				flake = {
					autoArchive = true, --prevent nil from throwing an annoying error message
					--autoEvalInputs = true,
				},
			},
		},
	},
})
