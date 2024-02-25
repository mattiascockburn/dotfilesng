local util = require('lspconfig.util')
return {
  settings = {
    yamlls = {
      path = "yaml-language-server",
    },
    filetypes = { 'helm' },
    root_dir = function(fname)
      return util.root_pattern('Chart.yaml')(fname)
    end
  },
}
