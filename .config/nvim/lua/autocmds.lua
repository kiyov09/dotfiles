local api = vim.api
local M = {}

-- Set nowrap for the quick fix window
local qfNoWrapAuGrp = api.nvim_create_augroup("QuickFixNoWrap", {
  clear = true,
})

api.nvim_create_autocmd("FileType", {
  command = "setlocal nowrap",
  pattern = "qf",
  group = qfNoWrapAuGrp,
})

-- Set tabs for: ruby, lua
api.nvim_create_autocmd("FileType", {
  command = "setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab",
  pattern = { "ruby", "lua" },
})

-- Set tabs for: js, ts (if package.json exists)
api.nvim_create_autocmd("FileType", {
  command = "if filereadable('package.json') | setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab | endif",
  pattern = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
})

-- Set conceallevel for markdown
api.nvim_create_autocmd("FileType", {
  command = "setlocal conceallevel=0",
  pattern = "markdown",
})

local highlightAuGrp = api.nvim_create_augroup("Highlight", {
  clear = true,
})

-- Highlight word under cursor on hold
M.set_au_cursor_hold = function (bufrn)
  api.nvim_create_autocmd("CursorHold", {
    callback = vim.lsp.buf.document_highlight,
    group = highlightAuGrp,
    buffer = bufrn
  })
end

-- Clear highlights on cursor move
M.set_au_cursor_move = function (bufrn)
  api.nvim_create_autocmd("CursorMoved", {
    callback = vim.lsp.buf.clear_references,
    group = highlightAuGrp,
    buffer = bufrn
  })
end

M.set_format_on_save = function ()
  api.nvim_create_autocmd("BufWritePre", {
    callback = function ()
      vim.lsp.buf.format({ timeout_ms = 2000 })
    end,
    group = api.nvim_create_augroup("Format", {
      clear = true,
    }),
  })
end

return M
