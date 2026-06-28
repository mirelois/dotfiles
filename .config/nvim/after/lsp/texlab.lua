return {
    settings = {
        texlab = {
            build = {
                args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                executable = "latexmk",
                onSave = true,
                forwardSearchAfter = true,
            },
            forwardSearch = {
                executable = "evince-synctex.sh",
                args = { 'sync', '%p', '%f', '%l' },
            },
            latexFormatter = "latexindent",
            latexindent = {
              modifyLineBreaks = true
            }
        }
    }
}
