vim.api.nvim_create_autocmd("FileType", {
    pattern = "uiua",
    callback = function()
        vim.cmd([[
      hi uiuaRed             guifg=#ed5e6a
      hi uiuaOrange          guifg=#ff8855
      hi uiuaYellow          guifg=#f0c36f
      hi uiuaBeige           guifg=#d7be8c
      hi uiuaGreen           guifg=#95d16a
      hi uiuaAqua            guifg=#6ad9ce
      hi uiuaBlue            guifg=#54b0fc
      hi uiuaIndigo          guifg=#8078f1
      hi uiuaPurple          guifg=#cc6be9
      hi uiuaPink            guifg=#f576d8
      hi uiuaLightPink       guifg=#f5a9b8
      hi uiuaFaded           guifg=#888888
      hi uiuaForegroundDark  guifg=#d1daec
      hi uiuaForegroundLight guifg=#334444
    ]])

        vim.fn["uiua#ApplyTheme"]()
    end,
})

return {
    'Apeiros-46B/uiua.vim',
}
