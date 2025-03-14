local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

--Remap space as leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- quickfix
keymap("n", "}c", ":cnext<cr>", opts)
keymap("n", "{c", ":cprev<cr>", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Quickswitch to next/prev tab
keymap("n", "<A-.>", ":tabnext<cr>", opts)
keymap("n", "<A-,>", ":tabprevious<cr>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Remap some stuff
-- Swap v and CTRL-V, because Block mode is more useful
keymap("n", "v", "<C-V>", opts)
keymap("n", "<C-V>", "v", opts)
keymap("v", "v", "<C-V>", opts)
keymap("v", "<C-V>", "v", opts)

keymap("n", "<Leader>q", ":close<cr>", opts)

-- Treat long lines as break lines (useful when moving around in them)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- command mode turbo
keymap("n", ";", ":", opts)

-- Do not pollute default registers on delete/paste
keymap("n", "x", "\"_x", opts)
keymap("v", "p", "\"_P", opts)

-- Terminal --
-- Better terminal navigation
-- Allow switching windows from any mode
keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<A-l>", "<C-\\><C-N><C-w>l", term_opts)
keymap("i", "<A-h>", "<C-\\><C-N><C-w>h", opts)
keymap("i", "<A-j>", "<C-\\><C-N><C-w>j", opts)
keymap("i", "<A-k>", "<C-\\><C-N><C-w>k", opts)
keymap("i", "<A-l>", "<C-\\><C-N><C-w>l", opts)
keymap("v", "<A-h>", "<C-\\><C-N><C-w>h", opts)
keymap("v", "<A-j>", "<C-\\><C-N><C-w>j", opts)
keymap("v", "<A-k>", "<C-\\><C-N><C-w>k", opts)
keymap("v", "<A-l>", "<C-\\><C-N><C-w>l", opts)

-- Spawn terminals
keymap("n", "<Leader>tt", ":spl term://zsh<cr>", opts)
keymap("n", "<Leader>tv", ":vspl term://zsh<cr>", opts)
keymap("n", "<Leader>T", ":tabe term://zsh<cr>", opts)

-- Easily hit escape in terminal mode.
keymap("t", "<esc><esc>", "<c-\\><c-n>")
keymap("t", "<M-[>", "<Esc>", term_opts)
keymap("t", "<C-v><Esc>", "<Esc>", term_opts)
keymap("t", "<Leader><Esc>", "<Esc>", term_opts)

-- Toggle paste mode
keymap("n", "<Leader>pp", "setlocal paste!<cr>", opts)

-- nvim-tree mappings
keymap("n", "<Leader>cc", ":Neotree toggle current reveal_force_cwd left<cr>", opts)

-- Fancy listchars action, make tab and friends visible
-- Also, add a toggle switch to the mix
-- ripped off of https://stackoverflow.com/questions/1675688/make-vim-show-all-white-spaces-as-a-character
keymap("n", "<leader>lc", ":set list!<CR>", opts)
keymap("i", "<leader>lc", "<C-o>:set list!<CR>", opts)
keymap("c", "<leader>lc", "<C-c>:set list!<CR>", opts)

-- Make CTRL+A and CTRL+E work (jump to beginning/end) in commandline mode
keymap("c", "<C-A>", "<Home>", opts)
keymap("c", "<C-E>", "<End>", opts)

-- No highlights
keymap("n", "<leader><cr>", ":noh<cr>", opts)

-- Autoformat paragraphs
keymap("n", "Q", "<NOP>", opts)
keymap("n", "Q", ":normal! gqip<cr>", opts)

-- Enable pasting in terminal insert mode through ALT+r + Register
vim.cmd [[tnoremap <expr><A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi']]

-- Git shortcuts
local status_ok, neogit = pcall(require, "neogit")
if status_ok then
  vim.api.nvim_create_user_command('G', function()
      require("neogit").open({ kind = "split" })
    end,
    {}
  )
end

local status_ok, b64 = pcall(require, "b64")
if status_ok then
  keymap("v", "<Leader>be", ":<c-u>lua require(\"b64\").encode()<cr>", opts)
  keymap("v", "<Leader>bd", ":<c-u>lua require(\"b64\").decode()<cr>", opts)
end

-- autosort go imports, ripped off of https://github.com/jamespwilliams/neovim-go-nix-develop/blob/0873f1a00444079db073e27ebbc40398a5c17cd6/base-neovim-config.lua
function OrgImports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-8")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { '*.go' },
  callback = function()
    vim.lsp.buf.format()
    OrgImports(1000)
  end,
  group = vim.api.nvim_create_augroup("lsp_document_format", { clear = true }),
})

-- neotest
keymap("n", "<leader>tu", ":lua require('neotest').summary.toggle()<cr>", term_opts)
keymap("n", "<leader>tt", ":lua require('neotest').run.run()<cr>", term_opts)
keymap("n", "<leader>ta", ":lua require('neotest').run.run(vim.fn.expand('%'))<cr>", term_opts)

-- debug
keymap("n", "<leader>du", ":lua require('dapui').toggle()<cr>", term_opts)
keymap("n", "<leader>db", ":lua require('dap').toggle_breakpoint()<cr>", term_opts)
keymap("n", "<leader>dc", ":lua require('dap').continue()<cr>", term_opts)
keymap("n", "<leader>di", ":DapStepInto<cr>", term_opts)
keymap("n", "<leader>dn", ":DapStepOver<cr>", term_opts)
keymap("n", "<leader>do", ":DapStepOut<cr>", term_opts)
keymap("n", "<leader>de", ":DapTerminate<cr>", term_opts)
keymap("n", "<leader>dt", ":lua require('dap-go').debug_test()<cr>", term_opts)
keymap("n", "<leader>dlt", ":lua require('dap-go').debug_last_test()<cr>", term_opts)

local function insertFullPath()
  local filepath = vim.fn.expand('%:p')
  for x in { '+', "p" } do
    vim.fn.setreg(x, filepath)
  end
  print('Yanked full path ' .. filepath)
end

local function insertRelativePath()
  local filepath = vim.fn.expand('%:~:.')
  for _, x in pairs({ '+', "p" }) do
    vim.fn.setreg(x, filepath)
  end
  print('Yanked relative path ' .. filepath)
end

keymap('n', '<leader>ypf', insertFullPath,
  { desc = 'Copy full path to file to clipboard', noremap = true, silent = true })

keymap('n', '<leader>ypr', insertRelativePath,
  { desc = 'Copy relative path to file to clipboard', noremap = true, silent = true })

-- working with lua
keymap("n", "<leader>x", "<cmd>.lua<CR>", { desc = "Execute the current line" })
keymap("n", "<leader>xf", "<cmd>source %<CR>", { desc = "Execute the current file" })
