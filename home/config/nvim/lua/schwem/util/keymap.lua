local M = {}

local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

M.imap = bind("i")
M.nmap = bind("n")
M.vmap = bind("x")

M.inoremap = bind("i", { noremap = true })
M.nnoremap = bind("n", { noremap = true })
M.vnoremap = bind("x", { noremap = true })

M.snnoremap = bind("n", { noremap = true, silent = true })

M.imaplocal = bind("i", { buffer = true } )
M.nmaplocal = bind("n", { buffer = true } )
M.vmaplocal = bind("v", { buffer = true } )

return M
