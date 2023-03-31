local ls = require("luasnip")
local s = ls.snippet
local extras = require("luasnip.extras")
local p = extras.partial

-- returns to current unix timestamp as string
local timestamp = function()
	return tostring(os.time())
end

ls.add_snippets("all", {
	s("date", p(os.date, "%Y-%m-%d")),
	s("time", p(os.date, "%H:%M")),
	s("unixts", p(timestamp)),
})
