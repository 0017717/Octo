repeat task.wait() until game.IsLoaded
repeat task.wait() until game.GameId ~= 0

-- Load libraries (using HttpGetAsync is generally better)
local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

local PlayerService = game:GetService("Players")
repeat task.wait() until PlayerService.LocalPlayer
local LocalPlayer = PlayerService.LocalPlayer

getgenv().Octo = {
    Source = "https://raw.githubusercontent.com/0017717/Octo/refs/heads/main/",
    Games = {
        ["Universal"] = {Name = "Universal", Script = "Universal"},
       ["3568135846"] = {Name = "Shadovis RPG", Script = "Shadovis"},
    }
}

local function GetGameInfo()
    local currentId = tostring(game.GameId)
    for ID, Info in pairs(Octo.Games) do
        if ID ~= "Universal" and currentId == ID then
            return Info
        end
    end
    return Octo.Games.Universal
end

local Options = Library.Options

Octo.Game = GetGameInfo()

local scriptPath = nil
local scriptContent = nil
local scriptChunk = nil
local success = false

if Octo.Game then
    if Octo.Game.Script == "Universal" then
        scriptPath = Octo.Source .. Octo.Game.Script .. ".lua"
    else
        scriptPath = Octo.Source .. "Games/" .. Octo.Game.Script .. ".lua"
    end

    success, scriptContent = pcall(function()
        return game:HttpGetAsync(scriptPath)
    end)

    if success and scriptContent and scriptContent ~= "" then
        success, scriptChunk = pcall(loadstring(scriptContent))
		Octo.Loaded = true
    end
end

if Octo.Loaded then
    Library:Notify{
        Title = "Octo",
        Content = "Script '" .. (Octo.Game and Octo.Game.Name or "Unknown") .. "' loaded.",
        SubContent = nil,
        Duration = 5
    }
end
