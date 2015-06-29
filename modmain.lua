-- Import the lib use.
modimport("libs/env.lua")

-- Actions Initialization.
use "data/actions/init"

-- Component Initialization.
use "data/components/init"

PrefabFiles = {
	"linley", 
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/linley.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/linley.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/linley.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/linley.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/linley_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/linley_silho.xml" ),

    Asset( "IMAGE", "bigportraits/linley.tex" ),
    Asset( "ATLAS", "bigportraits/linley.xml" ),
	
	Asset( "IMAGE", "images/map_icons/linley.tex" ),
	Asset( "ATLAS", "images/map_icons/linley.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_linley.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_linley.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_linley.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_linley.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

--local SITCOMMAND = GLOBAL.Action(4, true, true, 10,	false, false, nil)
--local SITCOMMAND_CANCEL = GLOBAL.Action(4, true, true, 10, false, false, nil)--

--local resolvefilepath = GLOBAL.resolvefilepath
--local Ingredient = GLOBAL.Ingredient
--local RECIPETABS = GLOBAL.RECIPETABS
--local Recipe = GLOBAL.Recipe
--local TECH = GLOBAL.TECH

--local summonbeserker_recipe = AddRecipe("summonbeserker",
--{GLOBAL.Ingredient("grail", 1, "images/inventoryimages/grail.xml")},
--RECIPETABS.WAR, TECH.NONE,
--nil, nil, nil, nil, nil,
--"images/inventoryimages/summonbeserker.xml", "summonbeserker.tex")
--summonbeserker_recipe.tagneeded = false
--summonbeserker_recipe.builder_tag ="illya_builder"
--summonbeserker_recipe.atlas = resolvefilepath("images/inventoryimages/summonbeserker.xml")

--GLOBAL.STRINGS.NAMES.SUMMONBESERKER = "Berserker"
--GLOBAL.STRINGS.RECIPE_DESC.SUMMONBESERKER = "Summon a hero."
--GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SUMMONBESERKER = {"Berserker"}
--GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.SUMMONBESERKER.GENERIC = "What a rather scary human."

--GLOBAL.STRINGS.NAMES.ILLYABIRD = "Zelle"
--GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYABIRD = "A helpful familiar."

--GLOBAL.STRINGS.NAMES.GRAIL = "Holy Grail"
--GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.GRAIL = "It grants wishes!"

--GLOBAL.STRINGS.NAMES.BESERKERSWORD = "Berserker's Stone Sword/Axe"
--GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.BESERKERSWORD = "What a MASSIVE weapon!"

--GLOBAL.STRINGS.NAMES.ILLYAHAT = "Illya's Winter hat"
--GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ILLYAHAT = "Nice and snug!"

--AddMinimapAtlas("images/inventoryimages/summonbeserker.xml")
--AddMinimapAtlas("images/inventoryimages/grail.xml")

--AddReplicableComponent("followersitcommand")

--SITCOMMAND.id = "SITCOMMAND"
--SITCOMMAND.str = "Order to Stay"
--SITCOMMAND.fn = function(act)
--	local targ = act.target
--	if targ and targ.components.followersitcommand then
--		act.doer.components.locomotor:Stop()
--		act.doer.components.talker:Say("Stay Berserker!!")
--		targ.components.followersitcommand:SetStaying(true)
--		targ.components.followersitcommand:RememberSitPos("currentstaylocation", GLOBAL.Point(targ.Transform:GetWorldPosition())) 
--		return true
--	end
--end
--AddAction(SITCOMMAND)

--SITCOMMAND_CANCEL.id = "SITCOMMAND_CANCEL"
--SITCOMMAND_CANCEL.str = "Order to Follow"
--SITCOMMAND_CANCEL.fn = function(act)
--	local targ = act.target
--	if targ and targ.components.followersitcommand then
--		act.doer.components.locomotor:Stop()
--		act.doer.components.talker:Say("Berserker come!")
--		targ.components.followersitcommand:SetStaying(false)
--		return true
--	end
--end
--AddAction(SITCOMMAND_CANCEL)

--AddComponentAction("SCENE", "followersitcommand", function(inst, doer, actions, rightclick)
--	if rightclick and inst.replica.followersitcommand then
--		if not inst.replica.followersitcommand:IsCurrentlyStaying() then
--			table.insert(actions, GLOBAL.ACTIONS.SITCOMMAND)
--		else
--			table.insert(actions, GLOBAL.ACTIONS.SITCOMMAND_CANCEL)
--		end
--	end
--end)

local function HealthPostInit(self)
	local OldRecalculatePenalty = self.RecalculatePenalty
	local function RecalculatePenalty(self, forceupdatewidget)
		local mult = GLOBAL.TUNING.REVIVE_HEALTH_PENALTY_AS_MULTIPLE_OF_EFFIGY
		mult = mult * GLOBAL.TUNING.EFFIGY_HEALTH_PENALTY
		local maxrevives = (self.maxhealth - 50)/mult
		if self.numrevives > maxrevives then
			self.numrevives = maxrevives
		end
		OldRecalculatePenalty(self, forceupdatewidget)
	end
	self.RecalculatePenalty = RecalculatePenalty
end

AddComponentPostInit('health', HealthPostInit) --

---- add tradable component to various gear
--function HF_addtradablecomponenttoprefab(inst)
--	if not inst.components.tradable then
--		inst:AddComponent("tradable")
--	end
--end--

--AddPrefabPostInit("beserkersword", HF_addtradablecomponenttoprefab)
--AddPrefabPostInit("armor_sanity", HF_addtradablecomponenttoprefab)
--AddPrefabPostInit("umbrella", HF_addtradablecomponenttoprefab)
--AddPrefabPostInit("grass_umbrella", HF_addtradablecomponenttoprefab)
--AddPrefabPostInit("torch", HF_addtradablecomponenttoprefab)
--AddPrefabPostInit("armorwood", HF_addtradablecomponenttoprefab)
--AddPrefabPostInit("armormarble", HF_addtradablecomponenttoprefab)
--AddPrefabPostInit("armorgrass", HF_addtradablecomponenttoprefab)
--AddPrefabPostInit("armorruins", HF_addtradablecomponenttoprefab)
---- DLC
--AddPrefabPostInit("armordragonfly", HF_addtradablecomponenttoprefab)--

--AddComponentPostInit("moisture", function(self)
--	local old = self.GetMoistureRate
--	self.GetMoistureRate = function(self)
--		local oldvalue = old(self)
--		local x, y, z = self.inst.Transform:GetWorldPosition()
--		local ents = GLOBAL.TheSim:FindEntities(x, y, z, 4, {'sheltercarrier'})
--		for k, v in pairs(ents) do 
--			if v.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) and 
--			v.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS).prefab == "umbrella" then
--				return 0
--			end
--			if v.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS) and 
--			v.components.inventory:GetEquippedItem(GLOBAL.EQUIPSLOTS.HANDS).prefab == "grass_umbrella" then
--				return oldvalue * 0.5
--			end
--		end
--		return oldvalue
--	end
--end)


-- The World Walk Ability, which allows Linley to Merge with the Earth itself
GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_R, 
function()
	local player = GLOBAL.ThePlayer
	player.canWorldWalk = true
	player.components.locomotor.walkspeed = 13
	player.components.locomotor.runspeed = 16
end
)

GLOBAL.TheInput:AddKeyUpHandler(GLOBAL.KEY_R,
function()
	local player = GLOBAL.ThePlayer
	player.canWorldWalk = false
	player.components.locomotor.walkspeed = 6
	player.components.locomotor.runspeed = 8.5
end
)

-- The Gebados Prison Ability, which freezes time around Linley.
GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_C, 
function()
	local player = GLOBAL.ThePlayer
	if player.components.aura then
		player.components.aura:Enable(true)
		--player.components.sanity:SetMax(100)
	end
end
)

GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_V,
function()
	local player = GLOBAL.ThePlayer
	if player.components.aura then
		player.components.aura:Enable(false)
		--player.components.sanity:SetMax(150)
	end
end
)

-- Fly Ability
GLOBAL.TheInput:AddKeyDownHandler(GLOBAL.KEY_F, 
function()
	local player = GLOBAL.ThePlayer
	local pt = Vector3(player.Transform:GetWorldPosition())
    if pt.y ~= 0 then
        pt.y = 0
        player.Physics:Stop()
        player.Physics:Teleport(pt.x,pt.y,pt.z)
	    player.DynamicShadow:Enable(false)
	else
		pt.y = 1
        player.Physics:Stop()
        player.Physics:Teleport(pt.x,pt.y,pt.z)
	    player.DynamicShadow:Enable(true)
	end
end
)


-- The character select screen lines
STRINGS.CHARACTER_TITLES.linley = "Linley Baruch"
STRINGS.CHARACTER_NAMES.linley = "Linley"
STRINGS.CHARACTER_DESCRIPTIONS.linley = "*Lucky Son Of A ...\n*Beirut\n*is OP"
STRINGS.CHARACTER_QUOTES.linley = "\"Have You Seen The True Face of God Mortal?\""

-- Custom speech strings
STRINGS.CHARACTERS.LINLEY = require "speech_linley"
--GLOBAL.STRINGS.CHARACTERS.ILLYA.DESCRIBE.SUMMONBESERKER = "BAHSAHKAH!"

-- The character's name as appears in-game 
STRINGS.NAMES.LINLEY = "Linley"

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.LINLEY = 
{
	GENERIC = "The True Face of God!",
	ATTACKER = "The Power of The One Called Destroyer of Worlds.",
	MURDERER = "Devourer of Souls!",
	REVIVER = "One Who Walks Hand In Hand With Death.",
	GHOST = "I Don't Know Whether to Laugh or Cry.",
}


AddMinimapAtlas("images/map_icons/linley.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("linley", "FEMALE")

