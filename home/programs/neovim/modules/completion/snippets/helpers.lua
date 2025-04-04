---Helper method for getting sinular of a plural word in loops
---Attempts to (in decreasing order of presedence):
-- - Convert a plural noun into a singular noun
-- - Return the first letter of the word
-- - Return "item" as a fallback
local function singular(input)
   local plural_word = input[1][1]
   local last_word = string.match(plural_word, "[_%w]*$")

   -- initialize with fallback
   local singular_word = "item"

   if string.match(last_word, ".s$") then
      -- assume the given input is plural if it ends in s. This isn't always
      -- perfect, but it's pretty good
      singular_word = string.gsub(last_word, "s$", "", 1)
   elseif string.match(last_word, "^_?%w.+") then
      -- include an underscore in the match so that inputs like '_name' will
      -- become '_n' and not just '_'
      singular_word = string.match(last_word, "^_?.")
   end

   return s("{}", i(1, singular_word))
end
