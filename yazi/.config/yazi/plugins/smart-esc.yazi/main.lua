--- @sync entry

local M = {}

function M:entry()
	if cx.active.mode.is_select or cx.active.mode.is_unset then
		ya.emit("escape", { visual = true })
		return
	end

	if #cx.active.selected > 0 then
		ya.emit("escape", { select = true })
		return
	end

	if #cx.yanked > 0 then
		ya.emit("unyank", {})
		return
	end

	ya.emit("quit", {})
end

return M
