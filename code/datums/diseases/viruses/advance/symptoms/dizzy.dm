/*
//////////////////////////////////////

Dizziness

	Hidden.
	Lowers resistance considerably.
	Decreases stage speed.
	Reduced transmittability
	Intense Level.

Bonus
	Shakes the affected mob's screen for short periods.

//////////////////////////////////////
*/

/datum/symptom/dizzy // Not the egg

	name = "Dizziness"
	id = "dizzy"
	stealth = 2
	resistance = -2
	stage_speed = -3
	transmittable = -1
	level = 4
	severity = 2

/datum/symptom/dizzy/Activate(datum/disease/virus/advance/A)
	..()
	if(prob(SYMPTOM_ACTIVATION_PROB*5))
		var/mob/living/M = A.affected_mob
		switch(A.stage)
			if(1, 2, 3, 4)
				to_chat(M, span_warning(pick("You feel dizzy.", "Your head spins.")))
			else
				to_chat(M, span_userdanger("A wave of dizziness washes over you!"))
				M.Dizzy(15 SECONDS)
	return
