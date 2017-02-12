 
local function notify(name, retcode)
	if(retcode == false) then
		minetest.chat_send_player(name, "Effect application failed. Effect was NOT applied.")
	else
		minetest.chat_send_player(name, "Effect applied. Effect ID: "..tostring(retcode))
	end
end

--Invisibility command 
 minetest.register_privilege("invisibility", {
	description = "Invisibility",
	give_to_singleplayer = true,
 })

 minetest.register_chatcommand("i", {
	params = "",
	description = "Makes player invisible.",
	privs = {invisibility},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("invisibility", 600, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
 })
 
 
minetest.register_chatcommand("cancelall", {
	params = "",
	description = "Cancels all your effects.",
	privs = {},
	func = function(name, param)
		local effects = playereffects.get_player_effects(name)
		for e=1, #effects do
			playereffects.cancel_effect(effects[e].effect_id)
		end
		minetest.chat_send_player(name, "All effects cancelled.")
	end,
})