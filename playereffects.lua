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

 
