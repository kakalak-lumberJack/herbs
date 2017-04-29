--Add fast priv on drinking coffee
if minetest.get_modpath("farming") ~= nil and farming.mod == "redo" and minetest.setting_getbool("herbs_tincures_coffee") ~= false then
  minetest.override_item("farming:coffee_cup", {on_use = 
  	function(itemstack, user, pointed_thing)
  		playereffects.apply_effect_type("fast", 600, user)
  		local hp = user:get_hp()
  		user:set_hp(hp+2)
  		itemstack:take_item(1)
  		itemstack:add_item("farming:drinking_cup")
  		return itemstack
  	end,
  })

  minetest.override_item("farming:coffee_cup_hot", {on_use = 
  	function(itemstack, user, pointed_thing)
  		playereffects.apply_effect_type("fast", 600, user)
  		local hp = user:get_hp()
  		user:set_hp(hp+2)
  		itemstack:take_item(1)
  		itemstack:add_item("farming:drinking_cup")
  		return itemstack
  	end,
  })
end
--register tinctures

plants = {
"viola",
"geranium",
"cactus",
"dandelion_yellow",
"tulip",
"rose",
"dandelion_white"
}

PLANTS = {
"Viola",
"Geranium",
"Cactus",
"Dandelion",
"Tulip",
"Rose",
"White Dandelion"
}

effects = {
"regenmana",--increase mana
"breath",--give breath
"high_speed",--increase player speed
"antigravity",--antigravity
"degen",--poison
"regen",--increase hp
"invisibility"--makes player invisible inspired by invisible mod
}

images = {
"violet",
"geranium",
"cactus",
"dandelion",
"tulip",
"rose",
"white_dandelion"
}

sources = {
"flowers:",
"flowers:",
"default:",
"flowers:",
"flowers:",
"flowers:",
"flowers:"
}

for number = 1,7 do

	local plant = plants[number]
	local PLANT = PLANTS[number]
	local effect = effects[number]
	local source = sources[number]
	local image = images[number]
	
	minetest.register_node("herbs:"..plant.."_tincture", {
		description = PLANT.." Tincture",
		drawtype = "plantlike",
		tiles = {"herbs_"..image.."_tincture.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		walkable = false,
		groups = {vessel = 1, oddly_breakable_by_hand = 3},
		selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
		},
		on_use = function(itemstack, user, pointed_thing)
      minetest.sound_play("herbs_tincture", {to_player = name, gain = 1.0,})
  		playereffects.apply_effect_type(effect, 30, user)
			itemstack:take_item(1)
			itemstack:add_item("vessels:glass_bottle")
			return itemstack
		end,
	
	}) 

  if minetest.get_modpath("farming") ~= nil and farming.mod == "redo" then
  	minetest.register_craft({
  		output = "herbs:"..plant.."_tincture",
  		recipe = {
  			{"farming:bottle_ethanol", source..plant, source..plant},
  			{source..plant, source..plant, source..plant},
  			{source..plant, source..plant, source..plant}
  		}
  	})
  else
  	minetest.register_craft({
  		output = "herbs:"..plant.."_tincture",
  		recipe = {
  			{"vessels:glass_bottle", source..plant, source..plant},
  			{source..plant, source..plant, source..plant},
  			{source..plant, source..plant, source..plant}
  		}
  	})
  end
end

if minetest.get_modpath("mana") == nil and mana == nil then minetest.unregister_item("herbs:viola_tincture") end