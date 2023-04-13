
-- Definicja klasy
local MyClass = {}
MyClass.__index = MyClass

function MyClass:new(value)
  local obj = {}
  setmetatable(obj, self)
  obj.value = value
  return obj
end

function MyClass:getValue()
  return self.value
end

-- Tworzenie obiektu
local obj = MyClass:new(42)
print(obj:getValue()) -- wyświetli 42


