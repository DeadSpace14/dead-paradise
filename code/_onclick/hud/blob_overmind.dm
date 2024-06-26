/mob/camera/blob/create_mob_hud()
	if(client && !hud_used)
		hud_used = new /datum/hud/blob_overmind(src)

/atom/movable/screen/blob
	icon = 'icons/mob/blob.dmi'

/atom/movable/screen/blob/MouseEntered(location,control,params)
	openToolTip(usr,src,params,title = name,content = desc, theme = "blob")

/atom/movable/screen/blob/MouseExited()
	closeToolTip(usr)

/atom/movable/screen/blob/BlobHelp
	icon_state = "ui_help"
	name = "Blob Help"
	desc = "Help on playing blob!"

/atom/movable/screen/blob/BlobHelp/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.blob_help()

/atom/movable/screen/blob/JumpToNode
	icon_state = "ui_tonode"
	name = "Jump to Node"
	desc = "Moves your camera to a selected blob node."

/atom/movable/screen/blob/JumpToNode/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.jump_to_node()

/atom/movable/screen/blob/JumpToCore
	icon_state = "ui_tocore"
	name = "Jump to Core"
	desc = "Moves your camera to your blob core."

/atom/movable/screen/blob/JumpToCore/MouseEntered(location,control,params)
	if(hud && hud.mymob && isovermind(hud.mymob))
		name = initial(name)
		desc = initial(desc)
	..()

/atom/movable/screen/blob/JumpToCore/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.transport_core()

/atom/movable/screen/blob/Blobbernaut
	icon_state = "ui_blobbernaut"
	name = "Produce Blobbernaut (60)"
	desc = "Produces a strong, intelligent blobbernaut from a factory blob for 60 resources.<br>The factory blob will be destroyed in the process."

/atom/movable/screen/blob/Blobbernaut/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.create_blobbernaut()

/atom/movable/screen/blob/StorageBlob
	icon_state = "ui_storage"
	name = "Produce Storage Blob (40)"
	desc = "Produces a storage blob for 40 resources.<br>Storage blobs will raise your max resource cap by 50."

/atom/movable/screen/blob/StorageBlob/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.create_storage()

/atom/movable/screen/blob/ResourceBlob
	icon_state = "ui_resource"
	name = "Produce Resource Blob (40)"
	desc = "Produces a resource blob for 40 resources.<br>Resource blobs will give you resources every few seconds."

/atom/movable/screen/blob/ResourceBlob/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.create_resource()

/atom/movable/screen/blob/NodeBlob
	icon_state = "ui_node"
	name = "Produce Node Blob (60)"
	desc = "Produces a node blob for 60 resources.<br>Node blobs will expand and activate nearby resource and factory blobs."

/atom/movable/screen/blob/NodeBlob/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.create_node()

/atom/movable/screen/blob/FactoryBlob
	icon_state = "ui_factory"
	name = "Produce Factory Blob (60)"
	desc = "Produces a factory blob for 60 resources.<br>Factory blobs will produce spores every few seconds."

/atom/movable/screen/blob/FactoryBlob/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.create_factory()

/atom/movable/screen/blob/ReadaptChemical
	icon_state = "ui_chemswap"
	name = "Readapt Chemical (50)"
	desc = "Randomly rerolls your chemical for 50 resources."

/atom/movable/screen/blob/ReadaptChemical/MouseEntered(location,control,params)
	if(hud && hud.mymob && isovermind(hud.mymob))
		name = initial(name)
		desc = initial(desc)
	..()

/atom/movable/screen/blob/ReadaptChemical/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.chemical_reroll()

/atom/movable/screen/blob/RelocateCore
	icon_state = "ui_swap"
	name = "Relocate Core (80)"
	desc = "Swaps a node and your core for 80 resources."

/atom/movable/screen/blob/RelocateCore/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.relocate_core()

/atom/movable/screen/blob/Split
	icon_state = "ui_split"
	name = "Split consciousness (100)"
	desc = "Creates another Blob Overmind at the targeted node. One use only.<br>Offspring are unable to use this ability."

/atom/movable/screen/blob/Split/Click()
	if(isovermind(usr))
		var/mob/camera/blob/B = usr
		B.split_consciousness()

/datum/hud/blob_overmind/New(mob/user)
	..()
	var/atom/movable/screen/using

	blobpwrdisplay = new /atom/movable/screen(null, src)
	blobpwrdisplay.name = "blob power"
	blobpwrdisplay.icon_state = "block"
	blobpwrdisplay.screen_loc = ui_health
	blobpwrdisplay.mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	blobpwrdisplay.layer = ABOVE_HUD_LAYER
	SET_PLANE_EXPLICIT(blobpwrdisplay, ABOVE_HUD_PLANE, mymob)
	static_inventory += blobpwrdisplay

	blobhealthdisplay = new /atom/movable/screen(null, src)
	blobhealthdisplay.name = "blob health"
	blobhealthdisplay.icon_state = "block"
	blobhealthdisplay.screen_loc = ui_internal
	static_inventory += blobhealthdisplay

	using = new /atom/movable/screen/blob/BlobHelp(null, src)
	using.screen_loc = "WEST:6,NORTH:-3"
	static_inventory += using

	using = new /atom/movable/screen/blob/JumpToNode(null, src)
	using.screen_loc = ui_inventory
	static_inventory += using

	using = new /atom/movable/screen/blob/JumpToCore(null, src)
	using.screen_loc = ui_zonesel
	static_inventory += using

	using = new /atom/movable/screen/blob/Blobbernaut(null, src)
	using.screen_loc = ui_id
	static_inventory += using

	using = new /atom/movable/screen/blob/StorageBlob(null, src)
	using.screen_loc = ui_belt
	static_inventory += using

	using = new /atom/movable/screen/blob/ResourceBlob(null, src)
	using.screen_loc = ui_back
	static_inventory += using

	using = new /atom/movable/screen/blob/NodeBlob(null, src)
	using.screen_loc = using.screen_loc = ui_rhand
	static_inventory += using

	using = new /atom/movable/screen/blob/FactoryBlob(null, src)
	using.screen_loc = using.screen_loc = ui_lhand
	static_inventory += using

	using = new /atom/movable/screen/blob/ReadaptChemical(null, src)
	using.screen_loc = ui_storage1
	static_inventory += using

	using = new /atom/movable/screen/blob/RelocateCore(null, src)
	using.screen_loc = ui_storage2
	static_inventory += using

	using = new /atom/movable/screen/blob/Split(null, src)
	using.screen_loc = ui_acti
	static_inventory += using
