local function run_jq(args)
   -- Get all lines of current buffer
   local lines = vim.fn.getbufline(0, 1, -1)

   -- Join lines into string
   local buffer_contents = table.concat(lines, "\n")

   -- Construct jq command
   local cmd = { "jq" }
   -- Pass input string to jq
   table.insert(cmd, "-R")
   table.insert(cmd, "-")
   for i, v in ipairs(args) do
      table.insert(cmd, v)
   end

   -- Run command with input string
   local handle = io.popen(table.concat(cmd, " "), 'w')
   handle:write(buffer_contents)
   local result = handle:read("*a")
   handle:close()

   -- Print result
   print(result)
end

vim.api.nvim_create_user_command('Jq', function(args)
   run_jq(args.fargs)
end, { ... })
