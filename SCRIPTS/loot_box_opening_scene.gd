extends Control

var rarety = 0# 1-common 2-rare 3-mythical

var commonClosed = "res://SPRITES/RESOURCES/common_chest.png"
var commonOpened = "res://SPRITES/RESOURCES/common_empty_no_glow.png"
var rareClosed = "res://SPRITES/RESOURCES/chest_rare_closed.png"
var rareOpened = "res://SPRITES/RESOURCES/rare_empty_no_glow.png"
var mythicalClosed = "res://SPRITES/RESOURCES/mythical_no_glow.png"
var mythicalOpened = "res://SPRITES/RESOURCES/mythical_empty_no_glow.png"
var r1 : int

func _ready() -> void:
	refresh_info()
	
	Music.get_node("MusicGameStart").volume_db = -6.0
		
	rarety = Global.selected_chest_rarety# 1-common 2-rare 3-mythical
	randomize()
	r1 = randi_range(0,100)
	get_loot()
	
	$ChestOpened.hide()
	$ShineLeft.hide()
	$ShineMid.hide()
	$ShineRight.hide()
	$ShineGift1.modulate=Color(Color8(255,255,255,0))
	$ShineGift2.modulate=Color(Color8(255,255,255,0))
	$ShineGift3.modulate=Color(Color8(255,255,255,0))
	$ShineGift4.modulate=Color(Color8(255,255,255,0))
	$ShineLeft.scale = Vector2(2, 0)
	$ShineMid.scale = Vector2(2, 0)
	$ShineRight.scale = Vector2(2, 0)
	$ButtonBack.hide()
	$ButtonBack2.hide()
	$ButtonBack3.hide()

	if rarety == 1:
		$ChestClosed.texture = load(commonClosed)
		$ChestOpened.texture = load(commonOpened)
	elif rarety == 2:
		$ChestClosed.texture = load(rareClosed)
		$ChestOpened.texture = load(rareOpened)
	elif rarety == 3:
		$ChestClosed.texture = load(mythicalClosed)
		$ChestOpened.texture = load(mythicalOpened)
	

func refresh_info():
	$LabelGem.text = str(Global.gems)
	$LabelGold.text = str(Global.coins)
	
	$LabelKeys1.text = tr("_common_keys") + str(Global.common_keys)
	$LabelKeys2.text = tr("_rare_keys")+str(Global.rare_keys)
	$LabelKeys3.text = tr("_mythical_keys") + str(Global.mythical_keys)
	
	$LabelBooster1Num.text = str(Global.booster_2x_damage)
	$LabelBooster2Num.text = str(Global.booster_plus2HP)
	$LabelBooster3Num.text = str(Global.booster_meteor_destroyer)
	$LabelBooster4Num.text = str(Global.booster_score_booster)
	$LabelBooster5Num.text = str(Global.booster_turret_1)
	$LabelBooster6Num.text = str(Global.booster_turret_2)

func _on_timer_wait_at_start_timeout() -> void:
	$TimerShaking.start()
	shake = true
	Music.get_node("LootStart").play()

func _on_timer_shaking_timeout() -> void:
	Music.get_node("LootBoxOpening").play()
	$TimerOpeningShine.start()
	shake = false
	opening = true
	$ChestClosed.hide()
	$ChestOpened.show()
	
	$ShineLeft.show()
	$ShineMid.show()
	$ShineRight.show()

func _on_timer_opening_shine_timeout() -> void:
	
	Music.get_node("MusicGameStart").volume_db = 0.0
	Music.get_node("LootEnd").play()
	opening = false
	shine_hiding = true
	$ButtonBack.show()
	if rarety == 1:
		if Global.common_keys > 0:
			$ButtonBack3.show()
		else:
			$ButtonBack2.show()
	if rarety == 2:
		if Global.rare_keys > 0:
			$ButtonBack3.show()
		else:
			$ButtonBack2.show()
	if rarety == 3:
		if Global.mythical_keys > 0:
			$ButtonBack3.show()
		else:
			$ButtonBack2.show()
			
	refresh_info()

var shake :bool = false
var opening :bool = false
var shine_hiding :bool = false

#
#
#
var s = 0
var s_add = 4 # shake speed
var s_dist = 12 # shake distance

var shine_scaling = 0.0
var shine_gift_modulate = 0
var shine_scaling_width_max = 10.0
var shine_scaling_width = 0.0

func _process(_delta: float) -> void:
	if shake == true:
		if s>s_dist:
			s_add *=-1
		if s<-s_dist:
			s_add *=-1
		$ChestClosed.position = $ChestClosed.position+Vector2(s,0)
		s += s_add
	
	if opening == true:
		if shine_scaling < 20.0:
			if shine_scaling/2 < 2:
				shine_scaling_width = 2.0
			else:
				shine_scaling_width = shine_scaling/2
				
			$ShineLeft.scale = Vector2(shine_scaling_width, shine_scaling)
			$ShineMid.scale = Vector2(shine_scaling_width, shine_scaling)
			$ShineRight.scale = Vector2(shine_scaling_width, shine_scaling)
			shine_scaling += 1.0
			
		if shine_scaling>5 and shine_gift_modulate < 250:
			$ShineGift1.modulate=Color(Color8(255,255,255,shine_gift_modulate))
			$ShineGift2.modulate=Color(Color8(255,255,255,shine_gift_modulate))
			$ShineGift3.modulate=Color(Color8(255,255,255,shine_gift_modulate))
			if rarety == 3:
				$ShineGift4.modulate=Color(Color8(255,255,255,shine_gift_modulate))
				
			shine_gift_modulate += 1

	if shine_hiding == true:
		$ShineLeft.scale = Vector2(shine_scaling_width_max, 20)
		$ShineMid.scale = Vector2(shine_scaling_width_max, 20)
		$ShineRight.scale = Vector2(shine_scaling_width_max, 20)
		shine_scaling_width_max-=1.0
		if shine_scaling_width_max <= 1.0:
			$ShineLeft.hide()
			$ShineMid.hide()
			$ShineRight.hide()
			shine_hiding = false
			$ShineGift1.modulate=Color(Color8(255,255,255,255))
			$ShineGift2.modulate=Color(Color8(255,255,255,255))
			$ShineGift3.modulate=Color(Color8(255,255,255,255))
			if rarety == 3:
				$ShineGift4.modulate=Color(Color8(255,255,255,255))

func _on_button_back_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_loot_box.tscn")

func _on_button_back_2_pressed() -> void: # BUY MORE KEYS
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_shop.tscn")


func _on_button_back_3_pressed() -> void: # OPEN AGAIN
	if rarety == 1:
		if Global.common_keys >= 1:
			Global.common_keys -= 1
			Sound.get_node("Click").play()
			get_tree().change_scene_to_file("res://SCENES/loot_box_opening_scene.tscn")
	if rarety == 2:
		if Global.rare_keys >= 1:
			Global.rare_keys -= 1
			Sound.get_node("Click").play()
			get_tree().change_scene_to_file("res://SCENES/loot_box_opening_scene.tscn")
	if rarety == 3:
		if Global.mythical_keys >= 1:
			Global.mythical_keys -= 1
			Sound.get_node("Click").play()
			get_tree().change_scene_to_file("res://SCENES/loot_box_opening_scene.tscn")
#
#
# LOOOOT LOOOOOT LOOOOOOOOOOOT
#
#
#

var gift_pos_1 : Vector2 = Vector2(317, 169)
var gift_pos_2 : Vector2 = Vector2(551, 105)
var gift_pos_3 : Vector2 = Vector2(775, 169)
var gift_pos_4 : Vector2 = Vector2(550, 294)

var all_boosters = [tr("_all_booster_1"), tr("_all_booster_2"), tr("_all_booster_3"), tr("_all_booster_4"), tr("_all_booster_5"), tr("_all_booster_6")]

func get_loot():
	
	#
	# COMMON COMMON COMMON COMMON COMMON COMMON
	#
	# 80% -> 20-100G + 20-100G + 1-3B
	# 20% -> 25-200G + S + 1-3B
	#
	if rarety == 1:
		$ShineGift4/BoosterGift/BoosterGiftName.hide() 
		var r = randi_range(0,5)
		var r_xbooster_num = randi_range(1,3)
		var rbooster =  all_boosters[r]
		
		$ShineGift3/BoosterGift/BoosterGiftName.text = rbooster +"\n" +str(r_xbooster_num) +"x"
		if r == 0:
			Global.booster_2x_damage += r_xbooster_num
		elif r==1:
			Global.booster_meteor_destroyer += r_xbooster_num
		elif r==2:
			Global.booster_plus2HP += r_xbooster_num
		elif r==3:
			Global.booster_score_booster += r_xbooster_num
		elif r==4: 
			Global.booster_turret_1 += r_xbooster_num
		elif r==5:
			Global.booster_turret_2 += r_xbooster_num
			
		if r1 < 80: #80%
			var r_gold1 := randi_range(20,100)
			var r_gold2 := randi_range(20,100)
			
			$ShineGift2/Label.text = "+"+str(r_gold1)+tr("_coins")
			$ShineGift1/Label.text = "+"+str(r_gold2)+tr("_coins")
			
			$ShineGift2/Label.text = "+"+str(r_gold1)+tr("_coins")
			$ShineGift1/Label.text = "+"+str(r_gold2)+tr("_coins")
			
			$ShineGift1/ShipSkin.hide()
			$ShineGift1/Label2.hide()
			
			Global.coins += r_gold1
			Global.coins += r_gold2
			
		else: # 20%
			var r_gold1 := randi_range(25,200)
			
			$ShineGift2/Label.text = "+"+str(r_gold1)+tr("_coins")
			
			$ShineGift2/Label.text = "+"+str(r_gold1)+tr("_coins")
			
			$ShineGift1/Gold.hide()
			$ShineGift1/Label.hide()
			
			Global.coins += r_gold1
			
			var r_skin1 = randi_range(1,14) #1-14
			var r_skin2 = -1
			
			if PlayerShips.ship_skins_unlocked[r_skin1][0] == 0: # if the ship has NO skins yet -
				# 0 skins - unlock the firts one
				r_skin2 = 0
				$ShineGift1/Label2.text = tr("_new_skin")
			else: # player has alredy some skin
				if r_skin1 < 10:
					r_skin2 = randi_range(0,4) # 0-4
				else:
					r_skin2 = randi_range(0,6)
				
				if PlayerShips.ship_skins_unlocked[r_skin1][r_skin2] == 1:
					$ShineGift1/Label2.text = tr("_duplicate")
					Global.coins += 199
				else:
					$ShineGift1/Label2.text = tr("_new_skin")
					
			PlayerShips.ship_skins_unlocked[r_skin1][r_skin2] = 1 # UNLOCK
			$ShineGift1/ShipSkin.texture = PlayerShips.ship_skins[r_skin1][r_skin2]
			
	
	#
	# RARE RARE RARE RARE RARE RARE
	#
	# 40% -> 40-250G + 35-250G + 2-5B
	# 60% -> 75-500G + S + 2-5B
	#
	if rarety == 2:
		$ShineGift4/BoosterGift/BoosterGiftName.hide() 
		var r = randi_range(0,5)
		var r_xbooster_num = randi_range(2,5)
		var rbooster =  all_boosters[r]
		
		$ShineGift3/BoosterGift/BoosterGiftName.text = rbooster +"\n" +str(r_xbooster_num) +"x"
		if r == 0:
			Global.booster_2x_damage += r_xbooster_num
		elif r==1:
			Global.booster_meteor_destroyer += r_xbooster_num
		elif r==2:
			Global.booster_plus2HP += r_xbooster_num
		elif r==3:
			Global.booster_score_booster += r_xbooster_num
		elif r==4: 
			Global.booster_turret_1 += r_xbooster_num
		elif r==5:
			Global.booster_turret_2 += r_xbooster_num
			
		if r1 < 40: #40%
			var r_gold1 := randi_range(40,250)
			var r_gold2 := randi_range(35,250)
			
			$ShineGift2/Label.text = "+"+str(r_gold1)+tr("_coins")
			$ShineGift1/Label.text = "+"+str(r_gold2)+tr("_coins")
			
			$ShineGift2/Label.text = "+"+str(r_gold1)+tr("_coins")
			$ShineGift1/Label.text = "+"+str(r_gold2)+tr("_coins")
			
			$ShineGift1/ShipSkin.hide()
			$ShineGift1/Label2.hide()
			
			Global.coins += r_gold1
			Global.coins += r_gold2
		else: #60%
			var r_gold1 := randi_range(75, 500)
			
			$ShineGift2/Label.text = "+"+str(r_gold1)+tr("_coins")
			
			$ShineGift1/Gold.hide()
			$ShineGift1/Label.hide()
			
			Global.coins += r_gold1
			
			var r_skin1 = randi_range(1,14) #1-14
			var r_skin2 = -1
			
			if PlayerShips.ship_skins_unlocked[r_skin1][0] == 0: # if the ship has NO skins yet -
				# 0 skins - unlock the firts one
				r_skin2 = 0
				$ShineGift1/Label2.text = tr("_new_skin")
			else: # player has alredy some skin
				if r_skin1 < 10:
					r_skin2 = randi_range(0,4) # 0-4
				else:
					r_skin2 = randi_range(0,6)
				
				if PlayerShips.ship_skins_unlocked[r_skin1][r_skin2] == 1:
					$ShineGift1/Label2.text = tr("_duplicate")
					Global.coins += 199
				else:
					$ShineGift1/Label2.text = tr("_new_skin")
					
			PlayerShips.ship_skins_unlocked[r_skin1][r_skin2] = 1 # UNLOCK
			$ShineGift1/ShipSkin.texture = PlayerShips.ship_skins[r_skin1][r_skin2]
		
	#
	#
	# MYTHICAL MYTHICAL MYTHICAL MYTHICAL MYTHICAL MYTHICAL
	#
	# 100% -> 250-1000G + S + 2-4B + 1-5B
	#
	if rarety == 3:
		var r = randi_range(0,5)
		var r2 = randi_range(0,5)
		var r_xbooster_num1 = randi_range(2,4)
		var r_xbooster_num2 = randi_range(1,5)
		var rbooster1 =  all_boosters[r]
		var rbooster2 =  all_boosters[r2]
		
		var r_gold1 := randi_range(250, 1000)
		
		$ShineGift2/Label.text = "+"+str(r_gold1)+tr("_coins")
		
		Global.coins += r_gold1
		$ShineGift1/Label.hide()
		$ShineGift1/Gold.hide()
		
		$ShineGift3/BoosterGift/BoosterGiftName.text = rbooster1 +"\n" +str(r_xbooster_num1) +"x"
		if r == 0:
			Global.booster_2x_damage += r_xbooster_num1
		elif r==1:
			Global.booster_meteor_destroyer += r_xbooster_num1
		elif r==2:
			Global.booster_plus2HP += r_xbooster_num1
		elif r==3:
			Global.booster_score_booster += r_xbooster_num1
		elif r==4: 
			Global.booster_turret_1 += r_xbooster_num1
		elif r==5:
			Global.booster_turret_2 += r_xbooster_num1
		
		$ShineGift4/BoosterGift/BoosterGiftName.text = rbooster2 +"\n" +str(r_xbooster_num2) +"x"
		if r2 == 0:
			Global.booster_2x_damage += r_xbooster_num2
		elif r2==1:
			Global.booster_meteor_destroyer += r_xbooster_num2
		elif r2==2:
			Global.booster_plus2HP += r_xbooster_num2
		elif r2==3:
			Global.booster_score_booster += r_xbooster_num2
		elif r2==4: 
			Global.booster_turret_1 += r_xbooster_num2
		elif r2==5:
			Global.booster_turret_2 += r_xbooster_num2
			
		var r_skin1 = randi_range(1,14) #1-14
		var r_skin2 = -1
		
		if PlayerShips.ship_skins_unlocked[r_skin1][0] == 0: # if the ship has NO skins yet -
			# 0 skins - unlock the firts one
			r_skin2 = 0
			$ShineGift1/Label2.text = tr("_new_skin")
		else: # player has alredy some skin
			if r_skin1 < 10:
				r_skin2 = randi_range(0,4) # 0-4
			else:
				r_skin2 = randi_range(0,6)
			
			if PlayerShips.ship_skins_unlocked[r_skin1][r_skin2] == 1:
				$ShineGift1/Label2.text = tr("_duplicate")
				Global.coins += 199
			else:
				$ShineGift1/Label2.text = tr("_new_skin")
				
		PlayerShips.ship_skins_unlocked[r_skin1][r_skin2] = 1 # UNLOCK
		$ShineGift1/ShipSkin.texture = PlayerShips.ship_skins[r_skin1][r_skin2]
