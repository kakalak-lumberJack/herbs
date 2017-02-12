
--register player effects

--hallucination
playereffects.register_effect_type("hallucination", "Hallucination", nil, {"visual"},
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

--invisibility

local skin
local size
local collision
local nametag

 playereffects.register_effect_type("invisibility", "Invisibility", nil, {"appearance"},
	function(player)
		skin = player:get_properties().textures
		size = player:get_properties().visual_size
		collision = player:get_properties().collisionbox
		nametag = player:get_nametag_attributes()
		
		player:set_nametag_attributes({color = {a = 0, r = 255, g = 255, b  =255}})
		player:set_properties({
			visual = "mesh",
			textures = "invisible_skin.png",
			visual_size = {x=0, y=0},
			collisionbox= {0,0,0, 0,0,0},
		})
	end,
		function(effects, player)
			player:set_nametag_attributes(nametag)
			player:set_properties({
				visual = "mesh",
				textures = skin,
				visual_size = size,
				collisionbox = collision,
			})
		end

 )


--Speed effects group
-- Makes the user faster
playereffects.register_effect_type("high_speed", "High speed", nil, {"speed"}, 
	function(player)
		player:set_physics_override(6,nil,nil)
	end,
	
	function(effect, player)
		player:set_physics_override(1,nil,nil)
	end
)
 
-- Adds the fast privilege Keep the privilege even if the player dies
playereffects.register_effect_type("fast", "Allows fast movement", nil, {"privs"},
	function(player)
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(playername)
		privs.fast = true
		minetest.set_player_privs(playername, privs)
	end,
	function(effect, player)
		local privs = minetest.get_player_privs(effect.playername)
		privs.fast = nil
		minetest.set_player_privs(effect.playername, privs)
	end,
	false, -- not hidden
	false  -- do NOT cancel the effect on death
)
 
 --regen (antidote)
 playereffects.register_effect_type("regen", "Regeneration", "heart.png", {"health"},
	function(player)
		player:set_hp(player:get_hp()+1)
	end,
	nil, nil, nil, 4
)

--degen (toxin)
 playereffects.register_effect_type("degen", "Degeneration", nil, {"health"},
	function(player)
		player:set_hp(player:get_hp()-2)
	end,
	nil, nil, nil, 4
)

 --Slows loss of breath underwater
 
 playereffects.register_effect_type("breath", "Breath", nil, {"breath"},
	function(player)
		player:set_breath(player:get_breath()+1)
	end,
	nil, nil, nil, 4
)

--add mana
playereffects.register_effect_type("regenmana", "Regenerate Mana", nil, {"mana"},
	function(player)
		local name = player:get_player_name()
		mana.setregen(name, 5)
	end,
	
	function(effects, player)
		local name = player:get_player_name()
		mana.setregen(name, 1)
	end
)

--antigravity
playereffects.register_effect_type("antigravity", "Antigravity", nil, {"gravity"}, 
	function(player)
		player:set_physics_override(nil,nil,.25)
	end,
	
	function(effect, player)
		player:set_physics_override(nil,nil,1)
	end
)

