if not vim.filetype then
  return
end

vim.filetype.add({
  extension = {
    lock = "yaml",
  },
  filename = {
    ["go.mod"] = "gomod",
  },
  pattern = {
    [".*%.conf"] = "conf",
    [".*%.env%..*"] = "env",
  },
})
