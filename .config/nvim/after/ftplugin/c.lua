if vim.bo.filetype == "c" then -- C logic
	vim.keymap.set(
		"n",
		"<leader>cf",
		'i#include <stdio.h><CR><CR>int main() {<CR>printf("Hello!\\n");<CR><CR>return 0;<CR>}<Esc>'
	)
else -- C++ logic
	return
end
