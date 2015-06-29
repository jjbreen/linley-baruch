
local MakePlayerCharacter = require "prefabs/player_common"


local assets = {

        Asset( "ANIM", "anim/player_basic.zip" ),
        Asset( "ANIM", "anim/player_idles_shiver.zip" ),
        Asset( "ANIM", "anim/player_actions.zip" ),
        Asset( "ANIM", "anim/player_actions_axe.zip" ),
        Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
        Asset( "ANIM", "anim/player_actions_shovel.zip" ),
        Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
        Asset( "ANIM", "anim/player_actions_eat.zip" ),
        Asset( "ANIM", "anim/player_actions_item.zip" ),
        Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
        Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
        Asset( "ANIM", "anim/player_actions_fishing.zip" ),
        Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
        Asset( "ANIM", "anim/player_bush_hat.zip" ),
        Asset( "ANIM", "anim/player_attacks.zip" ),
        Asset( "ANIM", "anim/player_idles.zip" ),
        Asset( "ANIM", "anim/player_rebirth.zip" ),
        Asset( "ANIM", "anim/player_jump.zip" ),
        Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
        Asset( "ANIM", "anim/player_teleport.zip" ),
        Asset( "ANIM", "anim/wilson_fx.zip" ),
        Asset( "ANIM", "anim/player_one_man_band.zip" ),
        Asset( "ANIM", "anim/shadow_hands.zip" ),
        Asset( "SOUND", "sound/sfx.fsb" ),
        Asset( "SOUND", "sound/wilson.fsb" ),
        Asset( "ANIM", "anim/beard.zip" ),

        Asset( "ANIM", "anim/illya.zip" ),
        Asset( "ANIM", "anim/ghost_illya_build.zip" ),
}
local prefabs = {
}

-- Custom starting items
local start_inv = {
}

-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when loading or reviving from ghost (optional)
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8.5
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)

    if not inst:HasTag("playerghost") then
        onbecamehuman(inst)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "linley.tex" )
	
	inst:AddTag("linley_builder")
end



-- Gebados Prison Details
local function GebadosPrison(inst, target)
    if target.Sleep then
        target:Sleep(1)
    end
    if target.Physics then
        target.Physics:Stop()
    end
    if target.sg then
        --target.sg:GoToState("stunned")
        target:PushEvent("gotosleep")  
    end
end



-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "willow"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(100)
	inst.components.hunger:SetMax(150)
	inst.components.sanity:SetMax(200)
	inst.components.temperature.mintemp = 20
	
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8.5
	
	-- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1.0
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	inst:ListenForEvent("equip", function()
		inst.AnimState:ClearOverrideSymbol("swap_body")
	end)
		
	inst.Transform:SetScale(0.7, 0.7, 0.7)
		
	inst.OnLoad = onload
    inst.OnNewSpawn = onload

    inst.canWorldWalk = false

    inst:SetStateGraph("SGlinley")
    
    inst:AddComponent("aura")
    inst.components.aura.radius = 25
    inst.components.aura.tickperiod = .1
    inst.components.aura.auratestfn = GebadosPrison
end

return MakePlayerCharacter("linley", prefabs, assets, common_postinit, master_postinit, start_inv)
