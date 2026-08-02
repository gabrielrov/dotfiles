local M = {}

local set_cached_path = ya.sync(function(state, v)
	state.cached_path = v
end)
local get_cached_path = ya.sync(function(state)
	return state.cached_path
end)

function M:setup()
	local nvim_addr = os.getenv("NVIM")
	if not nvim_addr or nvim_addr == "" then
		return
	end
	ya.async(function()
		local child = Command("nvim")
			:arg({ "--server", nvim_addr, "--remote-expr", "expand('#:p')" })
			:stdout(Command.PIPED)
			:stderr(Command.PIPED)
			:spawn()
		if not child then
			return
		end
		local output = child:wait_with_output()
		if output and output.status.success then
			local path = output.stdout:gsub("%s+$", "")
			if path ~= "" then
				set_cached_path(path)
			end
		end
	end)
end

function M:entry()
	local path = get_cached_path()
	if path then
		ya.emit("reveal", { path })
	end
end

return M
