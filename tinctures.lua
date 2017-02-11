plants = {
"violet",
"geranium",
"cactus",
"dandelion",
"tulip",
"rose",
"white_dandelion"
}

PLANTS = {
"Violet",
"Geranium",
"Cactus",
"Dandelion",
"Tulip",
"Rose",
"White Dandelion"
}

effects = {
--increase mana
--give breath
--allow lava swimming
--anectdote
--poison
--increase hp
--invisibility
}

for number = 1,7 do

	local plant = plants[number]
	local PLANT = PLANTS[number]


	minetest.register_node("herbs:"..plant.."_tincture", {
		description = PLANT.." Tincture",
		drawtype = "plantlike",
		tiles = {plant.."_tincture.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		sunlight_propagates = true,
		walkable = false,
		groups = {vessel = 1, oddly_breakable_by_hand = 3},
		selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
		},
	
}) 

end