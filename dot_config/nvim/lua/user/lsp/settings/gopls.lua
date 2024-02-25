local status_ok, lspcfg = pcall(require 'go.lsp'.config())
if status_ok then
  return lspcfg
else
  return {}
end
