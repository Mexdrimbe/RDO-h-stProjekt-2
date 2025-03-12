--- THIS WAS JUST A FUN LITTLE EXPERIMENT, WON'T BE UPDATING THIS..

system.setScriptName("Horse Options")
local SESSION = menu.addSubmenu('self', '~t1~SESSION OPTIONS', '~t4~C~q~S~t1~N')
menu.addDivider(SESSION, '~t3~ HORSE ACTIONS:')
menu.addDivider(SESSION, '~t3~ (this will go for all players):')
local type = nil 

local horse_action_types = {
   1, -- HORSE_ACTION_TYPE_REAR_UPm, i: 1
   2, -- HORSE_ACTION_TYPE_THROW_RIDER (horse throw off both - rider and passenger), i: 2
   3, -- HORSE_ACTION_QUICK_STOP, i: 3
   5, -- horse rear up, i: 4
   8, -- HORSE_ACTION_SKID, i: 5
   9, -- horse throw passenger (rider remains in the saddle ), i: 6
   10 -- horse throw rider (passenger remains in the saddle ), i: 7
}
local horse_action_names = {
   "HORSE_ACTION_TYPE_REAR_UP",
   "HORSE_ACTION_TYPE_THROW_RIDER",
   "HORSE_ACTION_QUICK_STOP",
   "horse rear up",
   "HORSE_ACTION_SKID",
   "horse throw passenger (rider remains in the saddle )",
   "horse throw rider (passenger remains in the saddle )"
}


local msg = function(msg, condition)
   -- PA: IF CONDITION IS AT "true" YOU WILL SEND OUT A WARN NOTIFICATION, ELSE INFORMATION NOTIFICATION.
   -- PA: I WON'T MAKE AN "TITLE" SINCE I WILL ONLY NEED "Horse Options", THIS WILL ONLY SAVE MY TIME.
   if msg == nil or condition == nil then logger.logCustom("You need to fill all the params") return end 
   if condition then notifications.alertWarn("Horse Options", msg) return end 
   if not condition then notifications.alertInfo("Horse Options", msg) return end 
end 

local horse_actions = function(type) 
   player.forEach(function(player)
      local ped  = player.ped
      logger.logCustom(ped)
      local horse = natives.ped_getMount(ped) or natives.ped_getLastMount(ped) or 0 -- fallbacks
      local HORSEID = natives.entity_getPedIndexFromEntityIndex(horse)
      if not natives.ped_isPedOnMount(player.ped) then logger.logCustom(player.name) return end 
      natives.task_taskHorseAction(HORSEID, horse_action_types[type], ped, 0)
      for i, actions in ipairs(horse_action_types) do 
         if actions == 1 then msg("HORSE_ACTION_TYPE_REAR_UP", false) return 
         elseif actions == 2 then msg("HORSE_ACTION_TYPE_THROW_RIDER (horse throw off both - rider and passenger)", false) return 
         elseif actions == 3 then msg("HORSE_ACTION_QUICK_STOP", false) return 
         elseif actions == 5 then msg("horse rear up", false) return 
         elseif actions == 8 then msg("HORSE_ACTION_SKID", false) return 
         elseif actions == 9 then msg("horse throw passenger (rider remains in the saddle )", false) return 
         elseif actions == 10 then msg("horse throw rider (passenger remains in the saddle )", false) return 
         end
      end 
   end)
end 

local add_buttons = function()
   for i, actionName in ipairs(horse_action_names) do
      menu.addButton(SESSION, actionName, actionName, function()
         horse_actions(i)
      end)
   end
end

add_buttons()
