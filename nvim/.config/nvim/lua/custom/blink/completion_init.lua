return {
  sources = {
    text = {},
    markdown = {},
    gitcommit = { 'conventional_commits' },
  },
  config = {
    javascriptreact = require('custom.blink.completions.jsx-tsx'),
    typescriptreact = require('custom.blink.completions.jsx-tsx'),
    html = require('custom.blink.completions.html'),
    ejs = require('custom.blink.completions.html'),
    css = require('custom.blink.completions.css'),
    scss = require('custom.blink.completions.css'),
  },
}
