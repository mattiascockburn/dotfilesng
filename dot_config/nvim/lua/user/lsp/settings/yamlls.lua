-- local util = require('lspconfig.util')
return require("yaml-companion").setup({
  -- Add any options here, or leave empty to use the default settings
  -- lspconfig = {
  --   cmd = {"yaml-language-server"}
  -- },
  lspconfig = {
    schemas = {
      ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
      ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
        "/azure-pipeline*.y*l",
        "/.azure/**/*.y*l",
        "Azure-Pipelines/**/*.y*l",
        "pipelines/**/*.y*l",
        "Pipelines/**/*.y*l",
      },
      ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
      ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
      ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
      ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
      ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
      ["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] =
      "*gitlab-ci*.{yml,yaml}",
      ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] =
      "*api*.{yml,yaml}",
      ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
      "*docker-compose*.{yml,yaml}",
      ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] =
      "*flow*.{yml,yaml}",
    }
  }
})
