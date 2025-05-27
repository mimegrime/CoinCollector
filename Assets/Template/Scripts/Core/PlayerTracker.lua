--!Header("CheckPoints")
    --!SerializeField
    local checkpointSound : AudioShader = nil
    --!SerializeField
    local CheckPoint1 : Transform = nil
    --!SerializeField
    local CheckPoint2 : Transform = nil
    --!SerializeField
    local CheckPoint3 : Transform = nil
    --!SerializeField
    local CheckPoint4 : Transform = nil

CheckpointTransforms = {
    CheckPoint1,
    CheckPoint2,
    CheckPoint3,
    CheckPoint4,
}

--!Header("Winning Variables")
    --!SerializeField
    local winScore : number = 2
    --!SerializeField
    local winSound : AudioShader = nil

--Events
local updateScoreReq = Event.new("UpdateScoreReq")
local updateStageReq = Event.new("UpdateStageReq")

local respawnReq = Event.new("RespawnReq")
local respawnEvent = Event.new("RespawnEvent")

local winReq = Event.new("WinReq")
local winEvent = Event.new("WinEvent")

local myUIController = nil
players = {} -- a table variable to store current players  and info
activePlayers = 0

local function TrackPlayers(game, characterCallback)
    game.PlayerConnected:Connect(function(player) -- When a player joins a scene add them to the players table
        activePlayers = activePlayers + 1
        players[player] = {
            player = player,
            score = IntValue.new("score" .. tostring(player.id), 0),
            stage = IntValue.new("stage" .. tostring(player.id), 0) --Score is a Network integer with an ID built of the player's ID to ensure uniqueness
        }
        -- Each player is a `Key` in the table, with the values `player` and `score`

        player.CharacterChanged:Connect(function(player, character) 
            local playerinfo = players[player] -- After the player's character is instantiated store their info from the player table (`player`,`score`)
            if (character == nil) then return end --If no character instantiated return

            if characterCallback then -- If there is a character callback provided call it with a reference to the player info
                characterCallback(playerinfo)
            end
        end)
    end)

    game.PlayerDisconnected:Connect(function(player) -- Remove player from the current table if they disconnect
        players[player] = nil
        activePlayers = activePlayers - 1
    end)
end

--[[
    Client
]]
function self:ClientAwake()

    myUIController = self.gameObject:GetComponent(ObstacleHud)

    -- Create OnCharacterInstantiate as the callback for the Tracking function, 
    -- to access the playerinfo on client for each player that joins
    function OnCharacterInstantiate(playerinfo)
        local player = playerinfo.player
        local character = player.character

        --The function to run everytime someones score changes
        playerinfo.score.Changed:Connect(function(newVal, oldVal)
            Audio:PlayShader(checkpointSound)
            if player == client.localPlayer then
                --Update slider
                myUIController.UpdateMeter(newVal)
                --checking if score update matches win score condition -> fires win event
                if newVal >= winScore then
                    winReq:FireServer(client.localPlayer.name)
                end
            end
        end)
    end

    --FOR UPDATING VARIABLES EVENTS
    function UpdateScore(scoreIncrease)
        updateScoreReq:FireServer(scoreIncrease)
    end

    function UpdateStage(stage)
        updateStageReq:FireServer(stage)
        --print(client.localPlayer.name .. "is on Stage" .. tostring(stage))
    end
    --end of updating variable events
    
    --FOR RESPAWN EVENT
    function RespawnPlayer()
        local stage = players[client.localPlayer].stage.value
        if stage == 0 then respawnReq:FireServer(Vector3.new(0, 0, 0)); return end
        respawnReq:FireServer(CheckpointTransforms[stage].position)
    end

    respawnEvent:Connect(function(player)
        local stage = players[player].stage.value
        if stage == 0 then player.character:Teleport(Vector3.new(0, 0, 0)); return end
        player.character:Teleport(CheckpointTransforms[stage].position)
    end)
    --end of respawn event

    --FOR WIN EVENT
    function playWinEffect(winningPlayerName)
        Audio:PlayShader(winSound)
        myUIController.WinTrue(winningPlayerName); 
    end

    winEvent:Connect(function(winningPlayerName)
        playWinEffect(winningPlayerName)
    end)
    --end of win event

    -- Track players on Client with a callback
    TrackPlayers(client, OnCharacterInstantiate)
end

--[[
    Server
]]
function self:ServerAwake()
    -- Track players on the server, with no callback
    TrackPlayers(server)

    updateScoreReq:Connect(function(player, scoreIncrease)
        players[player].score.value += scoreIncrease 
    end)

    updateStageReq:Connect(function(player, stage)
        players[player].stage.value = stage 
    end)
    
    respawnReq:Connect(function(player, pos)
        player.character.transform.position = pos
        respawnEvent:FireAllClients(player)
    end)

    winReq:Connect(function(player, winningPlayerName)
        winEvent:FireAllClients(winningPlayerName)
    end)
end