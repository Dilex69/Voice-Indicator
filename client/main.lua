local QBCore = exports['qb-core']:GetCoreObject()
local isUiOpen = false
local isTalking = false
local isRadio = false

local function updateTalkingState(talking, radio)
local success, error = pcall(function()
SendNUIMessage({
type = "updateTalking",
isTalking = talking,
isUiOpen = isUiOpen,
isRadio = radio
})
end)
if not success then
QBCore.Functions.Notify("Error updating UI: " .. error, "error")
end
end

Citizen.CreateThread(function()
while true do
local sleep = 1000
local player = PlayerPedId()

if NetworkIsPlayerTalking(PlayerId()) then
if not isTalking then
isTalking = true
updateTalkingState(true, isRadio)
end
sleep = 0
else
if isTalking then
isTalking = false
updateTalkingState(false, isRadio)
end
end

Citizen.Wait(sleep)
end
end)

-- Add this event listener for radio usage
AddEventHandler('pma-voice:radioActive', function(isActive)
isRadio = isActive
updateTalkingState(isTalking, isRadio)
end)


-- Optional: Event handler for when player loads
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
updateTalkingState(false, false)
end)

-- Optional: Event handler for when player unloads
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
updateTalkingState(false, false)
end)