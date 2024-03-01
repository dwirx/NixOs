-- keymap
-- change leader
vim.g.mapleader = " "
vim.keymap.set("n", "<space", "<nop>", { silent = true })

-- resize buffer
vim.keymap.set("n", "<leader>m", ":MaximizerToggle<CR>")

vim.keymap.set("n", "<C-k>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":resize -2<CR>", { silent = true })

vim.keymap.set("n", "<C-l>", ":vertical resize +2<CR>", { silent = true })
vim.keymap.set("n", "<C-h>", ":vertical resize -2<CR>", { silent = true })

-- reload config
vim.keymap.set("n", "<leader><leader>x", ":source $MYVIMRC<CR>")

-- copy to clipboard
vim.keymap.set({ "v", "n" }, "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+yg_')

-- paste to clipbord
vim.keymap.set({ "v", "n" }, "<leader>p", '"+p')
vim.keymap.set({ "v", "n" }, "<leader>P", '"+P')

-- indent line in tab (becase of copilot :/)
vim.keymap.set("i", "<C-i>", "  ", { silent = true })

-- save and close buffer
--[[ vim.keymap.set("n", "<leader>w", ':bd<CR>', {silent= true})
            vim.keymap.set("n", "<leader>s", ':w<CR>', {silent= true})
            vim.keymap.set("n", "<leader>q", ':q<CR>', {silent= true}) ]]

-- splits
vim.keymap.set("n", "<leader>s", ":split<CR><C-w>j", { silent = true })
vim.keymap.set("n", "<leader>v", ":vsplit<CR><C-w>l", { silent = true })

-- fugitive conflict resolution
vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<CR>", { silent = true })
vim.keymap.set("n", "gdl", ":diffget //3<CR>", { silent = true })
vim.keymap.set("n", "gdh", ":diffget //2<CR>", { silent = true })

--------------------------------------------------------------------------
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


-- Move BLocks in visual Mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") --Move current line down
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") --Move current line up

vim.keymap.set("v", "L", ":normal! >gv<CR>")
vim.keymap.set("v", "H", ":normal! <gv<CR>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Multi line
vim.keymap.set("n", "ml", "<C-v>") --multiLine
vim.keymap.set("v", "ml", "<S-i>") -- multiline

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/hades<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Craft
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)


-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")
-- window management
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Change window to right" })
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Change window to left" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Change window to bottom" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Change window to top" })
keymap.set("n", "<C-x>", "<cmd>close<CR>", { desc = "Close current split" })


-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")
keymap.set('n', '<CR>', ':nohlsearch<CR><CR>', { noremap = true, silent = true })

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
keymap.set("n", "L", "$<left>")
keymap.set("n", "H", "^")

-- Macos Recorded
keymap.set("n", "Q", "@qj")
keymap.set("x", "Q", ":norm @q<CR>")
keymap.set("n", "fz", ":HopWord<CR>")
