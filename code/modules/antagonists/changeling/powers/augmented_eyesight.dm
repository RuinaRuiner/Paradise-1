/**
 * Augmented Eyesight: Gives you thermal and night vision - bye bye, flashlights. Also, high DNA cost because of how powerful it is.
 * Possible todo: make a custom message for directing a penlight/flashlight at the eyes - not sure what would display though.
 */
/datum/action/changeling/augmented_eyesight
	name = "Augmented Eyesight"
	desc = "Creates heat receptors in our eyes and dramatically increases light sensing ability."
	helptext = "Grants us thermal vision or flash protection. We will become a lot more vulnerable to flash based devices while thermal vision is active."
	button_icon_state = "augmented_eyesight"
	power_type = CHANGELING_PURCHASABLE_POWER
	dna_cost = 2
	chemical_cost = 0


/datum/action/changeling/augmented_eyesight/on_purchase(mob/user, /datum/antagonist/changeling/antag)
	if(!..())
		return FALSE

	var/obj/item/organ/internal/cyberimp/eyes/shield/ling/eyes = new(null)
	eyes.insert(user)


/datum/action/changeling/augmented_eyesight/sting_action(mob/living/carbon/user)
	if(!istype(user))
		return FALSE

	var/obj/item/organ/internal/cyberimp/eyes/eyes
	if(active)
		eyes = new /obj/item/organ/internal/cyberimp/eyes/shield/ling(null)
		active = FALSE
	else
		eyes = new /obj/item/organ/internal/cyberimp/eyes/thermals/ling(null)
		active = TRUE

	eyes.insert(user)
	return TRUE


/obj/item/organ/internal/cyberimp/eyes/shield/ling
	name = "protective membranes"
	desc = "These variable transparency organic membranes will protect you from welders and flashes and heal your eye damage."
	icon_state = "ling_eyeshield"
	eye_colour = "#000000"
	implant_overlay = null
	slot = INTERNAL_ORGAN_EYE_LING
	status = NONE
	aug_message = "We adjust our eyes to protect them from bright lights."


/obj/item/organ/internal/cyberimp/eyes/shield/ling/emp_act(severity)
	return


/obj/item/organ/internal/cyberimp/eyes/shield/ling/on_life()
	if(!QDELETED(owner))
		return

	var/update_flags = STATUS_UPDATE_NONE

	var/obj/item/organ/internal/eyes/eyes = owner.get_int_organ(/obj/item/organ/internal/eyes)
	if(owner.AmountBlinded() || owner.AmountEyeBlurry() || (eyes?.damage > 0))
		owner.reagents.add_reagent("oculine", 1)

	if((NEARSIGHTED in owner.mutations) || (BLINDNESS in owner.mutations))
		update_flags |= owner.CureNearsighted()
		update_flags |= owner.CureBlind()
		update_flags |= owner.SetEyeBlind(0)

	return ..() | update_flags


/obj/item/organ/internal/cyberimp/eyes/shield/ling/prepare_eat()
	var/obj/object = ..()
	object.reagents.add_reagent("oculine", 15)
	return object


/obj/item/organ/internal/cyberimp/eyes/thermals/ling
	name = "heat receptors"
	desc = "These heat receptors dramatically increases eyes light sensing ability."
	icon_state = "ling_thermal"
	eye_colour = "#000000"
	implant_overlay = null
	slot = INTERNAL_ORGAN_EYE_LING
	status = NONE
	aug_message = "We adjust our eyes to sense prey through walls."


/obj/item/organ/internal/cyberimp/eyes/thermals/ling/emp_act(severity)
	return


/obj/item/organ/internal/cyberimp/eyes/thermals/ling/insert(mob/living/carbon/M, special = ORGAN_MANIPULATION_DEFAULT)
	. = ..()
	if(ishuman(owner))
		var/mob/living/carbon/human/h_owner = owner
		h_owner.weakeyes = TRUE
		if(!h_owner.vision_type)
			h_owner.set_sight(/datum/vision_override/nightvision)


/obj/item/organ/internal/cyberimp/eyes/thermals/ling/remove(mob/living/carbon/M, special = ORGAN_MANIPULATION_DEFAULT)
	if(ishuman(owner))
		var/mob/living/carbon/human/h_owner = owner
		h_owner.weakeyes = FALSE
		h_owner.set_sight(null)
	. = ..()
