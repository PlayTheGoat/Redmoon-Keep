/mob/living/Login()
	login_fade()
	..()
	//Mind updates
	sync_mind()
	mind.show_memory(src, 0)

	//Round specific stuff
	if(SSticker.mode)
		switch(SSticker.mode.name)
			if("sandbox")
				CanBuild()
	update_a_intents()
	update_damage_hud()
	update_health_hud()
//	update_tod_hud()
	update_spd()

//	if (client && (stat == DEAD))
//		client.ghostize()

	var/turf/T = get_turf(src)
	if (isturf(T))
		update_z(T.z)

	//Vents
//	if(ventcrawler)
//		to_chat(src, span_notice("I can ventcrawl! Use alt+click on vents to quickly travel about the station."))

	if(ranged_ability)
		ranged_ability.add_ranged_ability(src, span_notice("I currently have <b>[ranged_ability]</b> active!"))



/mob/living/proc/login_fade()
	set waitfor = FALSE
	if(!client)
		return
	var/atom/movable/screen/F = new /atom/movable/screen/fullscreen/fade()
	client.screen += F
	sleep(40)
	if(!client)
		return
	client.screen -= F
	do_time_change()
