extends Control

var step :int = 0

func _ready() -> void:
	$T1.show()
	$T2.hide()
	$T3.hide()
	$T4.hide()
	$T5.hide()
	$STEP_1.hide()
	$STEP_1/Label.hide()
	$STEP_1/Button.hide()
	$STEP_1/Button2.hide()
	$Cursor1.hide()
	$Cursor2.hide()
	$Cursor3.hide()
	$Cursor4.hide()
	$Cursor5.hide()
	$Cursor6.hide()
	$Cursor7.hide()
	$T5/Cursor.hide()
	$T5/Cursor.hide()
	$T5/Cursor3.hide()
	$T4/CursorC.hide()
	$T4/CursorG.hide()
	$T2/ButtonShip2/Skin.texture = PlayerShips.ship_skins[6][0] 
	
	$T2/LabelGem.text = str(Global.gems)
	$T2/LabelGold.text = str(Global.coins)
	refresh_shop()
	if Global.muted == true:
		$ButtonSound/On.hide()
	else:
		$ButtonSound/Off.hide()

func refresh_shop():	
	$T2/LabelGem.text = str(Global.gems)
	$T2/LabelGold.text = str(Global.coins)
	$T4/LabelGem.text = str(Global.gems)
	$T4/LabelGold.text = str(Global.coins)
	
func _on_button_sound_pressed() -> void:
	Sound.get_node("Click").play()
	if Global.muted == false:
		$ButtonSound.text = "_unmute_volume"
		Global.sound_on_off()
		$ButtonSound/On.hide()
		$ButtonSound/Off.show()
	else:
		$ButtonSound.text = "_mute_volume"
		Global.sound_on_off()
		$ButtonSound/Off.hide()
		$ButtonSound/On.show()

func _on_button_tut_no_pressed() -> void:
	Sound.get_node("Select").play()
	Global.gems = 420
	Global.coins = 3000
	get_tree().change_scene_to_file("res://SCENES/scene_main.tscn")


func _on_button_tut_yes_pressed() -> void:
	Sound.get_node("Select").play()
	$T1.hide()
	$T2.show()
	$Timer.start()
	$Timer2.start()
	$STEP_1/Button2.show()

func _on_button_language_en_pressed() -> void:
	Sound.get_node("Click").play()
	TranslationServer.set_locale("en")  # English
	next_step() # TO REFRESH


func _on_button_language_sl_pressed() -> void:
	Sound.get_node("Click").play()
	TranslationServer.set_locale("sl")  # English
	next_step() # TO REFRESH


func _on_timer_timeout() -> void:
	$STEP_1.show()
	$STEP_1/Label.show()


func _on_timer_2_timeout() -> void:
	$STEP_1/Button.show()


func _on_button_pressed() -> void:
	Sound.get_node("Click").play()
	if step==0:
		step=1
		next_step()
		$STEP_1/Button.hide()
		
	elif step==14:
		step=15
		next_step()
		$T4.hide()
		$T2.show()
		$STEP_1/Button.hide()
		$Cursor5.show()

func next_step():
	$Cursor1.hide()
	$Cursor2.hide()
	if step == 1:
		$Cursor1.show()
		$Cursor2.show()
		$STEP_1/Label.text = tr("_step_1_text")
	
	elif step == 2:
		$STEP_1/Label.text = tr("_step_2_text_part1")
	
	elif step == 4:
		$STEP_1/Label.text = tr("_step_2_text_part3")
	
	elif step == 5:
		$STEP_1/Label.text = tr("_step_2_text_part4")
		
	elif step == 6:
		$STEP_1/Label.text = tr("_step_2_text_part2")
	
	elif step == 7:
		$STEP_1/Label.text = tr("_step_3")
		
	elif step == 8:
		$STEP_1/Label.text = tr("_step_3_p2")
	
	
	elif step == 9:
		$STEP_1/Label.text = tr("_step_3_p3")
	
		
	elif step == 10:
		$STEP_1/Label.text = tr("_step_4")
		
	elif step == 11:
		$STEP_1/Label.text = tr("_step_4_p2")
		
	elif step == 12:
		$STEP_1/Label.text = tr("_step_4_p3")
		
	elif step == 13:
		$STEP_1/Label.text = tr("_step_4_p4")
		
	elif step == 14:
		$STEP_1/Label.text = tr("_step_5")
		$STEP_1/Button.text = tr("_step_5_button")
		
	elif step==15:
		$STEP_1/Label.text = tr("_step_6")
		
	elif step==16:
		$STEP_1/Label.text = tr("_step_7")
		
	elif step==17:
		$STEP_1/Label.text = tr("_step_7_p2")



func _on_button_ship() -> void:
	Sound.get_node("Click").play()
	if step == 1:
		step = 2
		$Cursor1.hide()
		$Cursor2.hide()
		$T2.hide()
		$T3.show()
		$T3/CardX2/Skin.texture = PlayerShips.ship_skins[6][0]
		$T3/SpriteSkin.texture = PlayerShips.ship_skins[6][0]
		$T3/Timer.start()
		next_step()


var texture_id :int = 0
var fast_fingers :bool = false

func _on_button_skin_1_pressed() -> void:
	Sound.get_node("Select2").play()
	#$T3/CardX2/Skin.texture = PlayerShips.ship_skins[6][0]
	$T3/SpriteSkin.texture = PlayerShips.ship_skins[6][0]
	texture_id=0
	$Cursor7.show()
	if fast_fingers==false:
		step = 4
		$Cursor3.show()
		next_step()
	fast_fingers=true


func _on_button_skin_2_pressed() -> void:
	Sound.get_node("Select2").play()
	#$T3/CardX2/Skin.texture = PlayerShips.ship_skins[6][3]
	$T3/SpriteSkin.texture = PlayerShips.ship_skins[6][3]
	texture_id = 3
	$Cursor7.show()
	if fast_fingers==false:
		step = 4
		$Cursor3.show()
		next_step()
	fast_fingers=true


func _on_button_skin_3_pressed() -> void:
	Sound.get_node("Select2").play()
	#$T3/CardX2/Skin.texture = PlayerShips.ship_skins[6][2]
	$T3/SpriteSkin.texture = PlayerShips.ship_skins[6][2]
	texture_id = 2
	$Cursor7.show()
	if fast_fingers==false:
		step = 4
		$Cursor3.show()
		next_step()
	fast_fingers=true


func _on_button_select_pressed() -> void:
	$Cursor3.hide()
	$Cursor7.hide()
	$T2/ButtonShip2/Skin.texture = PlayerShips.ship_skins[6][texture_id] 
	Sound.get_node("Click").play()
	$T3/CardX2/Skin.texture = PlayerShips.ship_skins[6][texture_id]
	
	Global.selected_ship_id = 6
	Global.selected_skin_id = texture_id
	
	if fast_fingers == true:
		step = 5
		next_step()
		$T3/Timer2.start()
		#$STEP_1/Button.text = tr("_step_2_button")
		#$STEP_1/Button.show()
	


func _on_T3_timer_timeout() -> void:
	if fast_fingers == false:
		step = 6
		next_step()
		next_step()
		$Cursor3.show()


func _on_timer_back_timeout() -> void:
	step = 7
	$T3.hide()
	$T2.show()
	next_step()
	$Cursor4.show()


func _on_button_shop_pressed() -> void:
	Sound.get_node("Click").play()
	if step == 7:
		$Cursor4.hide()
		$T2.hide()
		$T4.show()
		$T4/Default.show()
		$T4/Gems.hide()
		$T4/Coins.hide()
		step = 8
		$T4/CursorC.show()
		next_step()


func _on_button_buy_gems_pressed() -> void:
	Sound.get_node("Select").play()
	if step == 9:
		step = 10
		next_step()
		Global.gems += 500
		$T4/Gems/Button.disabled = true
		$T4/Timer.start()
		
	refresh_shop()


func _on_timer_T4_timeout() -> void:
	step = 11
	$T4/CursorG.show()
	next_step()
	
	$T4/Gems.hide()
	$T4/Default.show()


func _on_button_buy_coins_pressed() -> void:
	Sound.get_node("Select").play()
	if step == 11:
		step = 12
		next_step()
		$T4/CursorG.hide()
		$T4/Default.hide()
		$T4/Coins.show()


func _on_button_goto_buy_gems_pressed() -> void:
	Sound.get_node("Click").play()
	if step == 8:
		$T4/Default.hide()
		step = 9
		$T4/CursorC.hide()
		next_step()
		$T4/Gems.show()


func _on_button_buy_gold_pressed() -> void:
	Sound.get_node("Select").play()
	if step == 12:
		step = 13
		next_step()
		Global.gems -= 80
		Global.coins += 3000
		$T4/Coins/Button.disabled = true
		refresh_shop()
		$T4/Timer2.start()


func _on_timer_gold_2_timeout() -> void:
	if step == 13:
		step = 14
		next_step()
		$T4/Default.show()
		$T4/Coins.hide()
		$STEP_1/Button.show()


func _on_button_start_pressed() -> void:
	Sound.get_node("Click").play()
	if step==15:
		$Cursor5.hide()
		step = 16
		$T5/Cursor.show()
		$T5/Cursor2.show()
		next_step()
		$T2.hide()
		$T5.show()

var checked_1 = false
var checked_2 = false

func _on_button_booster_1_pressed() -> void:
	Sound.get_node("Select2").play()
	$T5/ButtonBooster1/Check.show()
	checked_1 = true
	check_both()


func _on_button_booster_2_pressed() -> void:
	Sound.get_node("Select2").play()
	$T5/ButtonBooster2/Check.show()
	checked_2 = true
	check_both()
	
func check_both():
	if checked_1==true and checked_2==true:
		step=17
		$T5/Cursor.hide()
		$T5/Cursor2.hide()
		$T5/Cursor3.show()
		next_step()


func _on_button_easy_pressed() -> void:
	if step==17:
		$T5/Cursor3.hide()
		Global.set_level_difficulty = 1
		Global.enemy_counter = 0
		Global.booster_2x_damage_active = true
		Global.booster_plus2HP_active = true
		get_tree().change_scene_to_file("res://SCENES/scene_level_start.tscn")


func _on_button_booster_NO() -> void:
	Sound.get_node("NoEnergy").play()


func _on_button_YES() -> void:
	Sound.get_node("Select").play()


func _on_button_2_pressed() -> void:
	Sound.get_node("Select").play()
	Global.gems = 420
	Global.coins = 3000
	get_tree().change_scene_to_file("res://SCENES/scene_main.tscn")
