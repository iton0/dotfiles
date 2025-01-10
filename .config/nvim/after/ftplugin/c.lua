-- Apparently this file is run in both C and C++ files
if vim.bo.filetype == "c" then
	-- Should only be in C files
	vim.keymap.set(
		"n",
		"<leader>cf",
		'i#include <stdbool.h><CR>#include <stdio.h><cr>#include <stdlib.h><cr><cr>int main() {<CR>printf("Hello!\\n");<CR><CR>return 0;<CR>}<Esc>'
	)
else -- C++ logic
	return
end
