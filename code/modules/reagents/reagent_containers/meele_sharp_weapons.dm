/obj/item/reagent_containers/sharp_weapon
	name = "sharp weapon"
	desc = ""
	item_state = ""
	icon_state = ""
	amount_per_transfer_from_this = 3
	volume = 3
	possible_transfer_amounts = 3
	container_type = OPENCONTAINER
	force = 0
	throwforce = 0
	sharp = TRUE
	w_class = WEIGHT_CLASS_SMALL


/obj/item/reagent_containers/sharp_weapon/afterattack(mob/living/carbon/human/M, mob/user)
	. = ..()
	if(!reagents.total_volume)
		return
	if(!iscarbon(M))
		return
	var/blood_id = M.get_blood_id()
	if(!blood_id)
		if(!M.bleed_rate)
			reagents.reagent_list = null

	if(reagents.total_volume) // Ignore flag should be checked first or there will be an error message.
		if(M.reagents)
			var/list/injected = list()
			for(var/datum/reagent/R in reagents.reagent_list)
				injected += R.name

				//var/primary_reagent_name = reagents.get_master_reagent_name()
				//var/fraction = min(amount_per_transfer_from_this / reagents.total_volume, 1)
				//reagents.reaction(M, REAGENT_INGEST, fraction)
				//var/trans = reagents.trans_to(M, amount_per_transfer_from_this)
				//var/contained = english_list(injected)

			return TRUE
