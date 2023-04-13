-- Importowanie bibliotek
local Lui = require("LUI")
local TestEZ = require("TestEZ")

-- Definicja testów
local tests = {
  {"Test przycisku", function()
    local button = Lui.Button("Test")
    assert(button:GetText() == "Test", "Nieprawidłowy tekst na przycisku")
  end},
  
  {"Test pola tekstowego", function()
    local textField = Lui.TextField("Test")
    assert(textField:GetText() == "Test", "Nieprawidłowy tekst w polu tekstowym")
  end},
  
  -- Dodaj kolejne testy...
}

-- Uruchamianie testów
local results = TestEZ.TestBootstrap:run(tests)

-- Wyświetlanie wyników testów
print(TestEZ.Reporter.TextReporter:report(results))
