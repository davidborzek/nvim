local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("java", {
	s("sout", fmt("System.out.println({})", { i(1, "text") })),
})
