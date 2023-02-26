local wk = require("which-key")

wk.register({
    ["<leader>d"] = {
        name = "Debug",

        c = { ":DapContinue<cr>", "Continue" },
		i = { ":DapStepInto<cr>", "Step Into" },
		o = { ":DapStepOver<cr>", "Step Over" },
		O = { ":DapStepOut<cr>", "Step Out" },
        t = { ":DapToggleBreakpoint<cr>", "Toggle Breakpoint" },
		u = { ":lua require('dapui').toggle()<cr>", "Toggle DAP UI" },
    }
})
