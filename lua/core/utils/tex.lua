local settings = require("core.settings")

local function get_out_dir()
	return os.getenv("TEX_OUT_DIR") or settings.tex_output_dir
end

local function get_tex_file()
	return os.getenv("TEX_FILE") or settings.tex_file
end

-- creates the given output directory and all child directories in the output directory
-- that contain *.tex files. This is needed for latexmk and pdflatex to build
-- in the given output directory.
local function mk_out_dirs(out)
	local cwd = vim.fn.getcwd()
	local dirs = {}

	-- get a list of all *.tex fles
	local cwd_content = vim.split(vim.fn.glob(cwd .. "/**/*.tex"), "\n", { trimempty = true })
	for _, value in pairs(cwd_content) do
		-- remove the `cwd` from the path
		value = string.sub(value, string.len(cwd) + 1)
		-- get the dirname from the path
		value = string.match(value, "(.*/)")
		-- append dir
		dirs[out .. value] = true
	end

	-- create all output directories
	for dir in pairs(dirs) do
		vim.fn.mkdir(cwd .. "/" .. dir, "p")
	end
end

local M = {}

-- compiles the given tex file to the given output directory.
M.compile = function()
	local out = get_out_dir()

	vim.notify("Comiling TeX document. This might take a while...", "info", { title = "TeX Compile" })

	mk_out_dirs(out)

	local on_exit = function(res)
		if res.code ~= 0 then
			vim.notify(res.stdout .. res.stderr, "error", { title = "TeX Compile" })
			return
		end

		vim.notify("Successfully compiled!", "info", { title = "TeX Compile" })
	end

	vim.system({
		"latexmk",
		"-pdf",
		"-file-line-error",
		"-halt-on-error",
		"-interaction=nonstopmode",
		"-outdir=" .. out,
		get_tex_file() .. ".tex",
	}, {}, on_exit)
end

-- shows the logs of the last compilation.
M.logs = function()
	local out = get_out_dir()
	vim.cmd("e " .. out .. "/main.log")
end

-- cleans the build directory.
M.clean = function()
	local out = get_out_dir()
	vim.cmd("silent !rm -rf " .. out)
end

-- opens the comiled pdf file in zathura.
M.view = function()
	local out = get_out_dir()
	local file = get_tex_file() .. ".pdf"

	vim.cmd("silent !zathura " .. out .. "/" .. file .. " &")
end

return M
