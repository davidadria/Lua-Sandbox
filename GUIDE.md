# Guía LUA

## Index

- Comments
- Variables
- Control Flow
- Modules
- Functions
- Metatables
- Bonus :)

## Comments

```lua
-- basic comment

--[[
    this is also a comment
]]
```

## Variables

```lua
local num = 3

local string = 'string'
local crazy = [[Multi line and literal]]

local true, lie = true, false

local nothing = nil
```

## Tables

Parecido a arrays, listas, mapas, etc, pero empezando en 1

```lua
-- as list
local list = {'first', 2, false, function() print("Funcion") end}
print("Posicion 1 -> " .. list[1])

-- as map
local map = {
    'key' = 'string',
    ['expresion'] = 'valor', -- este mejor probablemente por consistencia de datos
    [function() end] = true
}
```

## Control Flow

```lua
local fav_acc = {"texto1", "texto2", "texto3"}
-- # obtiene la longitud de la lista

-- listas
for index = 1, #fav_acc do
    print(index, fav_acc[index])
end

-- mapas
for key, value in pairs(fav_acc) do
    print(key, value)
end

-- existe elseif
if name != nil then
    print('Hola ' .. name)
end
```

## Modules

```lua
local M = {}
M:myFunction = function () end
return M

local foo = require 'foo'
foo:myFunction()

local returns_more_values = function ()
    return 1,2,3,4
end

-- ... para recibir x numero de variables
local myTable = {}

-- diferencias entre . y :
function myTable.something(self, ...) end
function myTable:something(...) end
```

## Functions

```lua
local function hello(name)
    print("Hello ", name)
end

local greet = function(name)
    -- .. es para concatenar
    print('Hello ' .. name .. '!')
end
```

## Metatables

```lua
local vector = {}
vector._add = function(left, right)
    return setmetatable({
        left[1] + right[1],
        left[2] + right[2],
    }, vector)
end


```
