local dap = require("dap")

dap.adapters.go = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = {
			"dap",
			"-l",
			"127.0.0.1:${port}",
		},
	},
}

dap.configurations.go = {
	{
		type = "go",
		name = "Launch File",
		request = "launch",
		program = "${file}",
	},
}

require("core.plugins.dap.settings").setup({ open_repl = true })
