local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
	s("package", fmt("package {}", { i(1, "xxx") })),
	s("pmain", t("package main")),
	-- functions
	s("fmain", t("func main() {}")),
	s("finit", t("func init() {}")),
	s("func", {
		t("func "),
		i(1, "Xxx"),
		t("() () {", "\t"),
		t({ "\t", "}" }),
	}),
	-- test functions
	s("test", {
		t("func Test"),
		i(1, "Xxx"),
		t("(t *testing.T) {", "\t"),
		t({ "\t", "}" }),
	}),
	s("testm", {
		t("func TestMain(m *testing.M) {", "\t"),
		t({ "\t", "}" }),
	}),
	-- fmt
	s("pl", fmt("fmt.Println({})", { i(1, "text") })),
	s("pf", fmt("fmt.Printf({})", { i(1, "text") })),
	s("sf", fmt("fmt.Sprintf({})", { i(1, "text") })),
	-- type
	s(
		"type",
		fmt("type {} {}", {
			i(1, "MyType"),
			i(2, "int"),
		})
	),
	s("types", {
		t("type (", "\t"),
		t({ "\t", ")" }),
	}),
	s("tstruct", {
		t("type "),
		i(1, "MyStruct"),
		t(" struct {", "\t"),
		t({ "\t", "}" }),
	}),
	s("tinterface", {
		t("type "),
		i(1, "MyInterface"),
		t(" interface {", "\t"),
		t({ "\t", "}" }),
	}),
	-- loops
	s("for", {
		t("for "),
		i(1, "i"),
		t(" := "),
		i(2, "0"),
		t("; "),
		i(3, "i"),
		t(" "),
		i(4, "<"),
		t(" "),
		i(5, "count"),
		t("; "),
		i(6, "i++"),
		t({ " {", "\t" }),
		t({ "\t", "}" }),
	}),
})
