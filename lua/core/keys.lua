local map = vim.keymap.set

-- clear search on escape
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { silent = true })

-- exit
map("n", "<leader>q", ":qa<CR>", { desc = "Exit", silent = true })

-- exit and save all
map("n", "<leader>Q", ":wqa<CR>", { desc = "Exit and save all", silent = true })

-- save all
map("n", "<leader>w", ":wa<CR>", { desc = "Save all", silent = true })
