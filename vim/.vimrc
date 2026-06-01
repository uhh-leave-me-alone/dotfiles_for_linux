" === Основы ===
set relativenumber                  " нумерация строк
set cursorline              " подсветка текущей строки
highlight CursorLine cterm=NONE ctermbg=236 guibg=#45475a
set showmode                " показывать режим
set showcmd                 " показывать команду в статусбаре

" === Отступы ===
set tabstop=4               " размер таба
set shiftwidth=4            " размер отступа
set expandtab               " пробелы вместо табов
set autoindent              " автоотступ
set smartindent             " умный отступ

" === Поиск ===
set hlsearch                " подсветка результатов
set incsearch               " инкрементальный поиск
set ignorecase              " игнор регистра
set smartcase               " но не игнорировать если есть заглавные

" === Внешний вид ===
set termguicolors           " 256 цветов
syntax on                   " подсветка синтаксиса
set background=dark         " тёмная тема

" === Курсор ===
let &t_SI = "\e[6 q"        " палочка в insert mode
let &t_EI = "\e[2 q"        " блок в normal mode

" === Удобство ===
set mouse=a                 " мышь
set clipboard=unnamedplus   " системный буфер обмена
set wrap                    " перенос строк
set linebreak               " перенос по словам
set scrolloff=8             " отступ при прокрутке
set encoding=utf-8          " кодировка

" === Статусбар ===
set laststatus=2            " всегда показывать
set statusline=%f\ %m%r%h%w\ [%Y]\ [%{&ff}]\ %=\ row:%l/%L\ col:%c


" === Just some handy tools ===
nnoremap <Esc> :nohl<CR> 

" === Auto brackets ===
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {<CR>}<Esc>O
inoremap " ""<Left>
inoremap ' ''<Left>

" ===Navigation without ctrl+w"
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
