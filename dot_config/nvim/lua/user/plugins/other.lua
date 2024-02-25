local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local status_ok, other = pcall(require, "other-nvim")
if not status_ok then
  return
end

other.setup({
  mappings = {
    "golang",
  },
})

keymap("n", "<leader>ll", "<cmd>:Other<CR>", opts)
keymap("n", "<leader>ltn", "<cmd>:OtherTabNew<CR>", opts)
keymap("n", "<leader>lp", "<cmd>:OtherSplit<CR>", opts)
keymap("n", "<leader>lv", "<cmd>:OtherVSplit<CR>", opts)
keymap("n", "<leader>lc", "<cmd>:OtherClear<CR>", opts)
keymap("n", "<leader>lt", "<cmd>:Other test<CR>", opts)
keymap("n", "<leader>ls", "<cmd>:Other scss<CR>", opts)
