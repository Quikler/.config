return {
     'ggandor/leap.nvim',
     lazy = false,
     dependencies = { 'tpope/vim-repeat'  },
     config = function() 
        require('leap').add_default_mappings()
        vim.cmd [[ hi LeapLabelPrimary  cterm=nocombine ctermfg=0 ctermbg=12 gui=nocombine guifg=Black guibg=#99ccff ]]
     end
}
