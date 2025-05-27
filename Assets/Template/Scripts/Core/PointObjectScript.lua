--!Type(ClientAndServer)

--!SerializeField
local ScoreIncrease : number = 1
--!SerializeField
local moveValues : Vector3 = nil --values for how far to move object
local moveTurnValue : number = 1 --switches between moving 

local respawnObjectReq = Event.new("RespawnObjectReq")
local respawnObjectEvent = Event.new("RespawnObjectEvent")

local playerTracker = require("PlayerTracker")

function self:ClientAwake()
    
    function self:OnTriggerEnter(other : Collider)
        local playerCharacter = other.gameObject:GetComponent(Character)
        if playerCharacter == nil then return end  -- Break if no Character component
        
        local player = playerCharacter.player
        if client.localPlayer == player then
            respawnObjectReq:FireServer()
            playerTracker.UpdateScore(ScoreIncrease)
        end
    end

    function RespawnObject()
        if moveTurnValue == 1 then 
            self.transform.position += moveValues
            moveTurnValue = 0
        elseif moveTurnValue == 0 then
            self.transform.position -= moveValues
            moveTurnValue = 1
        end
    end

    respawnObjectEvent:Connect(function()
        RespawnObject()
    end)
end

function self:ServerAwake()
    respawnObjectReq:Connect(function()
        respawnObjectEvent:FireAllClients()
    end)
end