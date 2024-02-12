/obj/item/implant/cqc
	name = "CQC bio-chip"
	desc = "Teaches you the CQC in 5 short instructional videos beamed directly into your eyeballs."
	icon = 'icons/obj/library.dmi'
	icon_state ="cqcmanual"
	implant_state = "implant-default"
	origin_tech = "materials=2;biotech=4;combat=5;syndicate=4"
	activated = BIOCHIP_ACTIVATED_ACTIVE
	implant_data = /datum/implant_fluff/cqc
	var/datum/martial_art/cqc/style = new


/obj/item/implant/cqc/activate(cause)
	var/mob/living/carbon/human/human_owner = imp_in
	if(!ishuman(human_owner) || !human_owner.mind)
		return
	if(istype(human_owner.mind.martial_art, /datum/martial_art/cqc))
		style.remove(human_owner)
	else
		style.teach(human_owner, TRUE)


/obj/item/implanter/cqc
	name = "bio-chip implanter (CQC)"
	imp = /obj/item/implant/cqc


/obj/item/implantcase/cqc
	name = "bio-chip case - 'CQC'"
	desc = "A glass case containing a bio-chip that can teach the user the art of CQC."
	imp = /obj/item/implant/cqc
