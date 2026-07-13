local cmp = require('cmp')

cmp.setup {
  -- Use Neovim's built-in snippet engine (0.10+) so LSP placeholder
  -- completions still expand — no LuaSnip/vsnip needed.
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  completion = {
    -- show the menu but don't auto-insert until you confirm
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- On-demand AI completion: only triggers minuet (qwen-coder via Ollama)
    -- when you explicitly ask, so the slow local model never blocks typing.
    ['<C-g>'] = require('minuet').make_cmp_map(),
    ['<C-e>'] = cmp.mapping.abort(),
    -- Enter confirms the selected item (or the first one if none selected)
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    -- minuet (AI) is intentionally NOT here — it's invoked on demand via
    -- <A-Space> so the slow local model doesn't stall normal completion.
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  },
  -- The local LLM is slow; give the on-demand minuet request time to arrive.
  performance = {
    fetching_timeout = 2000,
  },
}
