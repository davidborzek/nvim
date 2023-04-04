local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local extras = require("luasnip.extras")
local p = extras.partial
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- returns to current unix timestamp as string
local timestamp = function()
	return tostring(os.time())
end

-- generates a uuid via uuidgen
local uuidgen = function()
	if vim.fn.executable("uuidgen") == 0 then
		vim.notify({ "Could not generate uuid: ", "'uuidgen' not found in path." }, "error", { title = "Snippets" })
		return
	end

	local uuid = vim.fn.system("uuidgen")
	uuid = string.gsub(uuid, "%s+", "")
	return uuid
end

ls.add_snippets("all", {
	-- date and time
	s("date", p(os.date, "%Y-%m-%d")),
	s("time", p(os.date, "%H:%M")),
	s("unixts", p(timestamp)),
	-- network
	s("lh", t("localhost")),
	s("lh1", t("127.0.0.1")),
	s("h0", t("0.0.0.0")),
	s("http", fmt("http://{}", i(1, "localhost"))),
	s("https", fmt("https://{}", i(1, "localhost"))),
	s("url", fmt("https://{}:{}", { i(1, "localhost"), i(2, "8080") })),
	-- misc
	s("uuid", p(uuidgen)),
})
