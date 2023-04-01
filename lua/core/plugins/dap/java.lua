local dap = require("dap")

dap.configurations.java = {
	{
		name = "Launch (auto)",
		request = "launch",
		type = "java",
	},
}

require("core.plugins.dap.settings").setup()
