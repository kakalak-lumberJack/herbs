--register player effects
playereffects.register_effect_type("hallucination", "Hallucination Effect", nil, {"visual"},
      function(player)
        local num = 0
        local val1
        local val2
        local val3
        for val1 = 255, 0, -5 do
          num = num + 0.1
          minetest.after(num, function()
            player:set_sky({r = 255, g = val1, b = 255}, "plain", nil)
          end)
        end

        for val2 = 255, 0, -5 do
          num = num + 0.1

          minetest.after(num, function()
            player:set_sky({r = val2, g = 0, b = 255}, "plain", nil)
          end)
        end

        for val3 = 255, 0, -5 do
          num = num + 0.1
          minetest.after(num, function()
            player:set_sky({r = 0, g = 0, b = val3}, "plain", nil)
          end)
        end
        minetest.after(16, function()
          player:set_sky(nil, "skybox",
          {"herb_skull_sky.png", "herb_skull_sky_z.png", "herb_skull_sky_z.png",
        "herb_skull_sky_z.png", "herb_skull_sky_z.png",  "herb_skull_sky_z.png"})
          hrt = player:get_hp()
          player:set_hp(hrt-1)
        end)

        minetest.after(17, function()
          player:set_sky(nil, "regular", nil)
        end)
      end
)
--chat command
minetest.register_chatcommand("hallucination", {
    params = "",
    description = "Makes you hallucinate with slight damage",
    privs = {},
    func = function(name, param)
      local ret = playereffects.apply_effect_type("hallucination", 30, minetest.get_player_by_name(name))

    end,
})

--register mushroom
minetest.register_node("herbs:psychoactive_mushroom", {
    description = "Psychoactive Mushroom",
    tiles = {"herbs_psychoactive_mushroom.png"},
    drawtype = "plantlike",
    paramtype = "light",
    sunlight_propagates = true,
	  walkable = false,
	  buildable_to = true,
    light_source = 4,
	  groups = {snappy = 3, attached_node = 1},
	  sounds = default.node_sound_leaves_defaults(),
	  on_use = function(itemstack, user, pointed_thing)
  			playereffects.apply_effect_type("hallucination", 15, user)
        itemstack:take_item(1)
        return itemstack
  			end,
	  selection_box = {
		  type = "fixed",
		  fixed = {-0.35, -0.5, -0.35, 0.35, 0.125, 0.35}
	  },
 })
 --mushroom mapgen

 --local function register_mushroom("psychoactive_mushroom")
 	minetest.register_decoration({
 		deco_type = "simple",
 		place_on = {"default:dirt_with_grass"},
 		sidelen = 16,
 		noise_params = {
 			offset = 0,
 			scale = 0.006,
 			spread = {x = 200, y = 200, z = 200},
 			seed = 2,
 			octaves = 3,
 			persist = 0.66
 		},
 		biomes = {"deciduous_forest", "coniferous_forest"},
 		y_min = 1,
 		y_max = 31000,
 		decoration = "herbs:psychoactive_mushroom",
 	})
 --end
 -- Mushroom spread and death

 minetest.register_abm({
 	label = "Mushroom spread",
 	nodenames = {"herbs:psychoactive_mushroom"},
 	interval = 11,
 	chance = 50,
 	action = function(pos, node)
 	--[[	if minetest.get_node_light(pos, nil) == 15 then
 			minetest.remove_node(pos)
 			return
 		end]]--
 		local random = {
 			x = pos.x + math.random(-2, 2),
 			y = pos.y + math.random(-1, 1),
 			z = pos.z + math.random(-2, 2)
 		}
 		local random_node = minetest.get_node_or_nil(random)
 		if not random_node or random_node.name ~= "air" then
 			return
 		end
 		local node_under = minetest.get_node_or_nil({x = random.x,
 			y = random.y - 1, z = random.z})
 		if not node_under then
 			return
 		end

 		if (minetest.get_item_group(node_under.name, "soil") ~= 0 or
 				minetest.get_item_group(node_under.name, "tree") ~= 0) and
 				minetest.get_node_light(pos, 0.5) <= 3 and
 				minetest.get_node_light(random, 0.5) <= 3 then
 			minetest.set_node(random, {name = node.name})
 		end
 	end
 })
