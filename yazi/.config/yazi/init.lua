local old_empty = Current.empty
Current.empty = function(self, ...)
	if not self._folder.stage() then
		return {} -- hide "Loading..."
	else
		return old_empty(self, ...)
	end
end

require("zoxide"):setup({ update_db = true })

require("nvim-buffer"):setup()
require("bookmarks"):setup({
	persist = "all",
	file_pick_mode = "parent",
	last_directory = { enable = true, mode = "jump", persist = false },
})
