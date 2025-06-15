" Нумерация строк
set number
set relativenumber

" Настройки табуляции
set tabstop=4       " Количество пробелов, которое представляет символ табуляции
set shiftwidth=4    " Количество пробелов при автоматическом выравнивании (>> и <<)
set expandtab       " Преобразовывать символы табуляции в пробелы
set smarttab        " Умное поведение табуляции

" =============== Общие настройки =====================
syntax on
set number
set relativenumber
set cursorline
set termguicolors
set signcolumn=yes
set background=dark

" 🌌 Общий фон и текст
highlight Normal        guifg=#D0D0D0 guibg=#000000
highlight CursorLine    guibg=#1E1E1E
highlight Visual        guibg=#333333

" 💬 Комментарии — холодный пепел
highlight Comment       guifg=#5A5A5A gui=italic

" 🔤 Строки — лунный свет (светло-белый с холодным синим оттенком)
highlight String        guifg=#D9E4E9

" 🔢 Константы
highlight Constant      guifg=#AAAAAA

" 🧠 Ключевые слова (светло-белый с холодным синим оттенком)
highlight Statement     guifg=#B9C7D4 gui=bold
highlight PreProc       guifg=#B9C7D4
highlight Type          guifg=#888888 gui=italic

" 🧬 Идентификаторы
highlight Identifier    guifg=#D0D0D0

" 🔗 Ссылки, подчёркнутое (светло-белый с холодным синим оттенком)
highlight Underlined    guifg=#A9BAC5

" 📶 Статусбар и разделители
highlight StatusLine    guifg=#BBBBBB guibg=#000000
highlight VertSplit     guifg=#2A2A2A

" 🔢 Номера строк
highlight LineNr        guifg=#444444 guibg=#000000
highlight CursorLineNr  guifg=#CCCCCC gui=bold

" 📜 Меню автодополнения
highlight Pmenu         guifg=#D0D0D0 guibg=#222222
highlight PmenuSel      guifg=#121212 guibg=#A9BAC5

" 📁 Папки в дереве (светло-белый с холодным синим оттенком)
highlight Directory     guifg=#A9BAC5

call plug#begin('~/.vim/plugged')
" 📦 File explorer
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'   " для иконок

" 📋 LSP для C++
Plug 'neovim/nvim-lspconfig'

" 🤖 Автодополнение
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'

" 🔭 Навигация по проекту и поиск
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" 🖥️ Терминал
Plug 'akinsho/toggleterm.nvim'

" 🌈 Цветовая схема
Plug 'projekt0n/github-nvim-theme'

" Git
Plug 'tpope/vim-fugitive'
call plug#end()

" =============== nvim-tree =====================
nnoremap <C-n> :NvimTreeToggle<CR>

lua << EOF
require'nvim-tree'.setup {
  renderer = {
    icons = {
      show = {
        git = false,
        folder = false,
        file = false,
      },
    },
  }
}
EOF

" =============== telescope =====================
nnoremap <C-f> :Telescope live_grep<CR>

" =============== toggleterm =====================
lua << EOF
require("toggleterm").setup {
  size = 40,
  direction = "vertical",
  open_mapping = [[<C-t>]],
}
EOF

" =============== lspconfig + clangd =====================
lua << EOF
require'lspconfig'.clangd.setup{}
EOF

" =============== nvim-cmp =====================
lua << EOF
local cmp = require'cmp'
cmp.setup({
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
})
EOF

autocmd BufWritePre *.cpp,*.hpp,*.cc,*.h :silent! execute '%!clang-format'
