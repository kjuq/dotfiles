local M = {}

---@param bufnr integer Buffer handle, or 0 for current buffer
local function get_frontmatter(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	if lines[1] ~= '---' then
		return nil
	end
	local result = {}
	for i, line in ipairs(lines) do
		if i == 1 then
			goto continue
		end
		if line == '---' then
			break
		end
		local key, value = line:match('(%w+):%s*(.+)')
		result[key] = value
		::continue::
	end
	return result
end

function M.is_marp_buffer(bufnr)
	local frontmatter = get_frontmatter(bufnr)
	if not frontmatter then
		return false
	end
	return frontmatter.marp == 'true'
end

local function get_marp_info(bufnr)
	if not M.is_marp_buffer(bufnr) or vim.fn.executable('marp') == 0 then
		return nil
	end
	local inputpath = vim.api.nvim_buf_get_name(bufnr)
	local inputdir = vim.fs.dirname(inputpath)
	local outputfile = vim.fs.basename(inputpath):gsub([[.[^.]*$]], '.pdf')
	local outputpath = vim.fs.joinpath('/tmp/marp_output/', inputdir, outputfile)
	return {
		inputpath = inputpath,
		outputpath = outputpath,
	}
end

function M.compile_marp(bufnr)
	local marp = get_marp_info(bufnr)
	if not marp then
		return
	end
	vim.system({ 'marp', '--allow-local-files', marp.inputpath, '-o', marp.outputpath }, { text = true }, function(job)
		if job.code ~= 0 then
			error(('code: %d, stderr: %s'):format(job.code, job.stderr))
		end
	end)
end

function M.open_marp(bufnr)
	local open = vim.fn.has('unix') == 1 and 'xdg-open' or 'open'
	local marp = get_marp_info(bufnr)
	if not marp then
		return
	end
	vim.system({ open, marp.outputpath }, { text = true }, function(job)
		if job.code ~= 0 then
			error(('code: %d, stderr: %s'):format(job.code, job.stderr))
		end
	end)
end

return M
