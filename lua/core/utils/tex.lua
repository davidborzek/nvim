local M = {}

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

-- compiles the given tex file to the given output directory.
M.compile = function(file, out)
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
		file,
	}, {}, on_exit)
end

-- shows the logs of the last compilation.
M.logs = function(out)
	vim.cmd("e " .. out .. "/main.log")
end

-- cleans the build directory.
M.clean = function(out)
	vim.cmd("silent !rm -rf " .. out)
end

-- opens the comiled pdf file in zathura.
M.view = function(out)
	vim.cmd("silent !zathura " .. out .. "/main.pdf &")
end

return M
