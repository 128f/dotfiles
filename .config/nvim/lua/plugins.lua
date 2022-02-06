-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Simple plugins can be specified as strings
	use 'rstacruz/vim-closer'

	-- The essentials - syntax checking, finding files, autocomplete, etc
	-- use 'dense-analysis/ale'
	use 'junegunn/fzf'
	-- use { 'neoclide/coc.nvim', branch = 'release' }

	use 'neovim/nvim-lspconfig'

	use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
	use 'L3MON4D3/LuaSnip' -- Snippets plugin

	use 'preservim/nerdtree'
	-- use 'Valloric/YouCompleteMe'
	use 'tpope/vim-sleuth'
	use 'tpope/vim-commentary'
	use 'airblade/vim-rooter'
	use 'editorconfig/editorconfig-vim'

	--- tree plugin
	use 'kyazdani42/nvim-web-devicons' --- for file icons
	-- use 'kyazdani42/nvim-tree.lua'
	--- telescope.nvim 
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	-- " lsp stuff
	-- dependencies
	-- use 'nvim-lua/plenary.nvim'
	-- use 'nvim-lua/popup.nvim'
	-- " nvim-go
	-- use 'crispgm/nvim-go'
	-- " (recommend) LSP config
	-- use 'neovim/nvim-lspconfig'
	-- opengl shaders
	use 'tikhomirov/vim-glsl'
	-- nice rice
	use 'machakann/vim-highlightedyank'
	-- use 'tpope/vim-surround'
	-- use 'vim-airline/vim-airline'
	-- use 'ojroques/nvim-hardline'
	--- lines
	-- use 'lukas-reineke/indent-blankline.nvim'
	-- javascript
	use 'yuezk/vim-js'
	use 'maxmellon/vim-jsx-pretty'
	use 'leafgarland/typescript-vim'
	use 'peitalin/vim-jsx-typescript'
	-- use 'kien/ctrlp.vim'
	-- themes
	-- use 'chriskempson/base16-vim'
	-- use 'Soares/base16.nvim'
	use 'norcalli/nvim-base16.lua'
	-- godot
	use 'habamax/vim-godot'
	-- solidity
	use 'tomlion/vim-solidity'

	-- use {'andymass/vim-matchup', event = 'VimEnter'}
	-- use {
	-- 	'w0rp/ale',
	-- 	ft = {'sh', 'zsh', 'bash', 'c', 'cpp', 'cmake', 'html', 'markdown', 'racket', 'vim', 'tex'},
	-- 	cmd = 'ALEEnable',
	-- 	config = 'vim.cmd[[ALEEnable]]'
	-- }
	-- Plugins can have dependencies on other plugins
	-- use 'ms-jpq/coq_nvim'
        use { 'lukas-reineke/indent-blankline.nvim' }
	use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	use 'feline-nvim/feline.nvim'
	use {
		'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
		config = function() require('gitsigns').setup() end
	}

	-- You can specify multiple plugins in a single call
	-- use {'tjdevries/colorbuddy.vim', {'nvim-treesitter/nvim-treesitter', opt = true}}
end)


