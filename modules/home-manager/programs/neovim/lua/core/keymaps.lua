local tbi = require("telescope.builtin")
vim.keymap.set("n", "<leader><space>", tbi.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", tbi.live_grep, { desc = "Grep Files" })
