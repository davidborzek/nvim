local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.add_snippets("java", {
	s("sout", fmt("System.out.println({})", { i(1, "text") })),
	s(
		"psvm",
		fmt(
			[[
			public static void main(final String[] args) {{
				{}
			}}
			]],
			{ i(1) }
		)
	),
	s(
		"field",
		fmt("{access} {type} {name};", {
			access = i(1, "private"),
			type = i(2, "int"),
			name = i(3, "myInt"),
		})
	),
	s(
		"ffield",
		fmt("{access} final {type} {name};", {
			access = i(1, "private"),
			type = i(2, "int"),
			name = i(3, "myInt"),
		})
	),
	s(
		"sffield",
		fmt("{access} static final {type} {name};", {
			access = i(1, "private"),
			type = i(2, "int"),
			name = i(3, "myInt"),
		})
	),
	s(
		"class",
		fmt(
			[[
			public class {class_name1} {{
				public {class_name2}({args}) {{
				}}

			}}
			]],
			{ class_name1 = i(1, "MyClass"), class_name2 = rep(1), args = i(2) }
		)
	),
	s(
		"method",
		fmt(
			[[
			{access} {return_type} {name}({args}) {{
				{finally}	
			}}
			]],
			{
				access = i(1, "public"),
				return_type = i(2, "void"),
				name = i(3, "myMethod"),
				args = i(4),
				finally = i(0),
			}
		)
	),
	-- tests
	s(
		"test",
		fmt(
			[[
			@Test
			void test{name}() {{
				{finally}	
			}}
			]],
			{
				name = i(1, "MyMethod"),
				finally = i(0),
			}
		)
	),
	s(
		"beach",
		fmt(
			[[
			@BeforeEach
			void setUp() {{
				{finally}	
			}}
			]],
			{
				finally = i(0),
			}
		)
	),
	s(
		"ball",
		fmt(
			[[
			@BeforeAll
			void init() {{
				{finally}	
			}}
			]],
			{
				finally = i(0),
			}
		)
	),
})
