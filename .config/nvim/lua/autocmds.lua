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
      vim.lsp.buf.formatting_sync({}, 2000)
    end,
    group = api.nvim_create_augroup("Format", {
      clear = true,
    }),
  })
end

return M
