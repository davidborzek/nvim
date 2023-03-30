local lazy_git_url = "https://github.com/folke/lazy.nvim.git"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- install lazy.nvim when not already installed
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		lazy_git_url,
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("core.plugins", {
	install = {
		missing = true,
	},
	change_detection = {
		enabled = false,
		notify = true,
	},
})
