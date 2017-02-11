
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

 --mapgen with biomes
 	minetest.register_decoration({
 		deco_type = "simple",
 		place_on = {"default:dirt_with_grass"},
 		sidelen = 16,
 		noise_params = {
 			offset = 0,
 			scale = 0.004,
 			spread = {x = 200, y = 200, z = 200},
 			seed = 7,
 			octaves = 3,
 			persist = 0.66
 		},
 		--biomes = {"deciduous_forest", "coniferous_forest"},
 		y_min = 7,
 		y_max = 14,
 		decoration = "herbs:psychoactive_mushroom",
 	})
 --end

 -- Mushroom spread and death

 minetest.register_abm({
 	label = "Mushroom spread",
 	nodenames = {"herbs:psychoactive_mushroom"},
 	interval = 11,
 	chance = 100,
 	action = function(pos, node)
 		if minetest.get_node_light(pos, nil) <= 14 then
 			minetest.remove_node(pos)
 			return
 		end

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
