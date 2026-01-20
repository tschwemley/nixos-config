# Lua Quick Reference Cheatsheet                                  

## Variables & Types                                              
```lua                                                            
local x = 10          -- number                                   
local name = "Lua"    -- string                                   
local active = true   -- boolean                                  
local data = nil      -- nil                                      
-- No declaration keyword = global                                
```

## Strings                                                          

```lua
local s1 = 'hello'                                                
local s2 = "world"                                                
local s3 = [[multi-line                                           
    string]]                                                          
local len = #s1               -- length                           
local concat = s1 .. s2       -- concatenation                    
```

## Numbers                                                          

```lua
-- All numbers are double-precision floats                        
math.floor(3.14)     -- → 3                                       
math.ceil(3.14)      -- → 4                                       
math.max(1,2,3)      -- → 3                                       
```

## Booleans                                                         

```lua
-- False values: false, nil                                       
-- Everything else is true (including 0, "")                      
if flag then ... end                                              
```

## Control Flow                                                     

if condition then                                                 
    -- body                                                         
elseif condition2 then                                            
    -- body                                                         
else                                                              
    -- body                                                         
end                                                               

while condition do                                                
    -- body                                                         
end                                                               

repeat                                                            
    -- body (runs at least once)                                    
until condition                                                   

for i = 1, 10, 1 do    -- start, end, step                        
    print(i)                                                        
end                                                               

for key, value in pairs(table) do                                 
    print(key, value)                                               
end                                                               

for index, value in ipairs(array) do  -- ordered, array-only      
    print(index, value)                                             
end                                                               

## Functions                                                        

function add(a, b)                                                
    return a + b                                                    
end                                                               

-- Anonymous function                                             
local sub = function(a, b) return a - b end                       

-- First-class functions                                          
table.sort(list, function(a, b) return a > b end)                 

-- Variadic                                                       
function log(...)                                                 
    for i, v in ipairs({...}) do                                    
        print(v)                                                      
    end                                                             
end                                                               

## Tables (Arrays & Objects)                                        

-- Array-like                                                     
local arr = {10, 20, 30}                                          
arr[1] = 15         -- indexing starts at 1                       
table.insert(arr, 40)                                             
table.remove(arr, 1)                                              

-- Dictionary-like                                                
local person = {name = "Alice", age = 30}                         
print(person.name)        -- → "Alice"                            
print(person["age"])      -- → 30                                 

-- Mixed                                                          
local mixed = {[100] = "hundred", "first", "second"}              

## Table Length & Iteration                                         

local t = {1,2,3}                                                 
print(#t)                  -- → 3 (only sequential indices)       

for k, v in pairs(t) do    -- unordered traversal                 
    print(k, v)                                                     
end                                                               

for i = 1, #t do           -- ordered for arrays                  
    print(t[i])                                                     
end                                                               

## Metatables (Basic)                                               

local t1 = {value = 5}                                            
local t2 = {value = 10}                                           

local mt = {                                                      
    __add = function(a, b)                                          
        return {value = a.value + b.value}                            
    end                                                             
}                                                                 

setmetatable(t1, mt)                                              
setmetatable(t2, mt)                                              

local sum = t1 + t2        -- → {value = 15}                      

## Modules (Lua 5.1+)                                               

-- mylib.lua                                                      
local M = {}                                                      

function M.hello()                                                
    print("Hello from module")                                      
end                                                               

return M                                                          

-- Usage:                                                         
local mylib = require("mylib")                                    
mylib.hello()                                                     

## Error Handling                                                   

if error_condition then                                           
    error("Something went wrong")                                   
end                                                               

local success, result = pcall(function()                          
    -- potentially failing code                                     
end)                                                              

if not success then                                               
    print("Error:", result)                                         
end                                                               

## Common Built-in Libraries                                        

    Lib                            │ Example Usage                     
    ────────────────────────────────┼─────────────────────────────────────────
    string                        │  string.upper(s) ,  string.sub(s,1,3)
table                         │  table.insert(t, x) ,  table.concat(t)
math                          │  math.random() ,  math.sin()      
io                            │  io.write() ,  io.open()          
os                            │  os.time() ,  os.date()           

│ Note: Indexing starts at 1, not 0.
