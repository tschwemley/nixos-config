vim.api.nvim_create_user_command("Decrypt", "!sops -d --in-place %", {})
vim.api.nvim_create_user_command("Dump", function(opts)
   print(opts.args)
   print(opts.args[0])
   local ok, result = pcall(require, opts.args[0])
   if ok then
      if opts.args[1] ~= nil then
         result = result[opts.args[1]]
      end

      print(vim.inspect(result))
   else
      print("Error loading module: " .. opts.args)
   end
end, { nargs = "+" })
