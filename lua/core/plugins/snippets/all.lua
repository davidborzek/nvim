local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local extras = require("luasnip.extras")
local p = extras.partial
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- returns the current unix timestamp as string
local timestamp = function()
	return tostring(os.time())
end

-- generates a uuid
local uuidgen = function()
	local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
	return string.gsub(template, "[xy]", function(c)
		local v = (c == "x") and math.random(0, 0xf) or math.random(8, 0xb)
		return string.format("%x", v)
	end)
end

-- generates a random password
local pwgen = function(length, special_chars)
	local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
	if special_chars then
		chars = chars .. "!@#$%^&*()-_=+[{]}\\|;:'\",<.>/?"
	end

	local password = ""
	for _ = 1, length do
		local char_pos = math.random(1, #chars)
		password = password .. string.sub(chars, char_pos, char_pos)
	end
	return password
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
	-- pwgen
	s("pwgen", p(pwgen, 32, false)),
	s("pwgen_special", p(pwgen, 32, true)),
	s("pwgen16", p(pwgen, 16, false)),
	s("pwgen48", p(pwgen, 48, false)),
	s("pwgen64", p(pwgen, 64, false)),
})
