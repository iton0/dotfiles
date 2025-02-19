if vim.bo.filetype == "c" then -- C logic
	vim.keymap.set(
		"n",
		"<leader>cf",
		'i#include <stdbool.h><CR>#include <stdio.h><cr>#include <stdlib.h><cr><cr>int main() {<CR>printf("Hello!\\n");<CR><CR>return 0;<CR>}<Esc>'
	)
else -- C++ logic
	return
end
