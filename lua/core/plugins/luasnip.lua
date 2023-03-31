return {
	"L3MON4D3/LuaSnip",
	opts = {
		history = true,
		updateevents = "TextChanged,TextChangedI",
		delete_check_events = "TextChanged",
	},
	init = function()
		require("core.plugins.snippets.go")
	end,
}
