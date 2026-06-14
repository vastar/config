vim.o.swapfile = false -- Do not use a swapfile for the buffer
vim.o.fileencodings = "ucs-bom,utf-8,cp1251,koi8-r"

vim.o.number = true -- Print the line number in front of each line
vim.o.relativenumber = true -- Show the line number relative to the line with the cursor in front of each line
vim.o.numberwidth = 2 -- Minimal number of columns to use for the line number

vim.o.expandtab = true -- Use the appropriate number of spaces to insert a Tab
vim.o.tabstop = 2 -- Defines the column multiple used to display the Horizontal Tab character
vim.o.softtabstop = 2 -- Create soft tab stops, separated by 'softtabstop' number of columns
vim.o.autoindent = true -- Copy indent from current line when starting a new line
vim.o.smartindent = true -- Do smart autoindenting when starting a new line
vim.o.shiftwidth = 2 -- Number of columns that make up one level of (auto)indentation
vim.o.shiftround = true -- Round indent to multiple of 'shiftwidth'

vim.o.wrap = false -- When off lines will not wrap and only part of long lines will be displayed
vim.o.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor

vim.o.ignorecase = true -- Ignore case in search patterns
vim.o.smartcase = true -- Override the 'ignorecase' option if the search pattern contains upper case characters

vim.o.inccommand = "nosplit" -- Shows the effects of a command incrementally in the buffer

vim.o.splitright = true -- When on, splitting a window will put the new window right of the current one
vim.o.splitbelow = true -- When on, splitting a window will put the new window below the current one

vim.g.netrw_banner = 0 -- Suppress the banner
vim.g.netrw_liststyle = 3 -- Tree style listing
vim.g.netrw_preview = 1 -- Preview window shown in a vertically split window
vim.g.netrw_alto = 0 -- Change from left splitting to right splitting
vim.g.netrw_winsize = 15 -- Percentage of the current netrw buffer's window to be used for the new window
