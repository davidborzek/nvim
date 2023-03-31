local map = vim.keymap.set

-- clear search on escape
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { silent = true })
