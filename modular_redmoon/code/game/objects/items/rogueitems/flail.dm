/obj/item/rogueweapon/whip/antique/psywhip
	name = "Daybreak"
	desc = "I am wrath. I am silver. I am the mercy of HIM."
	icon = 'modular_redmoon/icons/weapons/32.dmi'
	icon_state = "psywhip"
	var/last_used = 0

/obj/item/rogueweapon/whip/antique/psywhip/pickup(mob/user)
	. = ..()
	if(!user.mind) // REDMOON ADD - добавлена проверка на mind, чтобы dummy не вызывал рантаймы при выборе профессии
		return
	var/mob/living/carbon/human/H = user
	var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	if(ishuman(H))
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
				H.Knockdown(10)
				H.Paralyze(10)
		if(W && W.transformed == TRUE)
			to_chat(H, span_userdanger("I can't pick up the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
		if(!HAS_TRAIT(H, TRAIT_INQUISITION))
			to_chat(H, span_userdanger("Not worthy of it!"))
			H.Knockdown(10)
			H.Paralyze(10)


/obj/item/rogueweapon/whip/antique/psywhip/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	. = ..()
	if(ishuman(M) && M.mind) // REDMOON EDIT - добавлена проверка на mind, чтобы dummy не вызывал рантаймы при выборе профессии
		var/mob/living/carbon/human/H = M
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
		if(H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
			to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
		if(V_lord)
			if(V_lord.vamplevel < 4 && !H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser))
				to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
				H.Knockdown(10)
				H.Paralyze(10)
		if(W && W.transformed == TRUE)
			to_chat(H, span_userdanger("I can't equip the silver, it is my BANE!"))
			H.Knockdown(10)
			H.Paralyze(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)


/obj/item/rogueweapon/whip/antique/psywhip/funny_attack_effects(mob/living/target, mob/living/user = usr, nodmg)
	if(world.time < src.last_used + 100)
		to_chat(user, span_notice("The silver effect is on cooldown."))
		return

	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/s_user = user
		var/mob/living/carbon/human/H = target
		var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
		var/datum/antagonist/vampirelord/lesser/V = H.mind.has_antag_datum(/datum/antagonist/vampirelord/lesser)
		var/datum/antagonist/vampirelord/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampirelord/)
		if(V)
			if(V.disguised)
				H.Knockdown(10)
				H.Paralyze(10)
				H.visible_message("<font color='white'>The silver weapon manifests the [H] curse!</font>")
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.adjustFireLoss(25)
				H.fire_act(1,10)
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
			else
				H.Stun(20)
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.Knockdown(10)
				H.Paralyze(10)
				H.adjustFireLoss(25)
				H.fire_act(1,10)
				H.apply_status_effect(/datum/status_effect/debuff/silver_curse)
				src.last_used = world.time
		if(V_lord)
			if(V_lord.vamplevel < 4 && !V)
				H.Knockdown(10)
				H.Paralyze(10)
				to_chat(H, span_userdanger("I'm hit by my BANE!"))
				H.adjustFireLoss(25)
				H.fire_act(1,10)
				src.last_used = world.time
			if(V_lord.vamplevel == 4 && !V)
				s_user.Stun(10)
				s_user.Paralyze(10)
				s_user.adjustFireLoss(25)
				s_user.fire_act(1,10)
				to_chat(s_user, "<font color='red'> The silver weapon fails!</font>")
				H.visible_message(H, span_userdanger("This feeble metal can't hurt me, I AM THE ANCIENT!"))
		if(W && W.transformed == TRUE)
			H.adjustFireLoss(25)
			H.Paralyze(10)
			H.Stun(10)
			H.adjustFireLoss(25)
			H.fire_act(1,10)
			to_chat(H, span_userdanger("I'm hit by my BANE!"))
			src.last_used = world.time
