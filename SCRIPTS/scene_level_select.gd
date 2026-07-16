extends Control

func _ready() -> void:
	$LabelGem.text = str(Global.gems)
	$LabelGold.text = str(Global.coins)
	$Skin.texture = PlayerShips.ship_skins[Global.selected_ship_id][Global.selected_skin_id] 
	
	$LabelMissions.text = ""
	$LabelMissions.text += "~M1: "+tr(str(MissionsBattlepass.active_missions[0].definition.desc))+"\n\n"
	$LabelMissions.text += "~M2: "+tr(str(MissionsBattlepass.active_missions[1].definition.desc))+"\n\n"
	$LabelMissions.text += "~M3: "+tr(str(MissionsBattlepass.active_missions[2].definition.desc))
	
	$ButtonBooster1.text = "( "+str(Global.booster_2x_damage)+" )  "
	$ButtonBooster2.text = "( "+str(Global.booster_plus2HP)+" )  "	
	$ButtonBooster3.text = "( "+str(Global.booster_meteor_destroyer)+" )  "
	$ButtonBooster4.text = "( "+str(Global.booster_score_booster)+" )  "
	$ButtonBooster5.text = "( "+str(Global.booster_turret_1)+" )  "
	$ButtonBooster6.text = "( "+str(Global.booster_turret_2)+" )  "
	
	if(Global.booster_2x_damage < 1):
		Global.booster_2x_damage_active = false
	if(Global.booster_plus2HP < 1):
		Global.booster_plus2HP_active = false
	if(Global.booster_score_booster < 1):
		Global.booster_score_booster_active = false
	if(Global.booster_meteor_destroyer < 1):
		Global.booster_meteor_destroyer_active = false
	if(Global.booster_turret_1 < 1):
		Global.booster_turret_1_active = false
	if(Global.booster_turret_2 < 1):
		Global.booster_turret_2_active = false
	
	if Global.booster_2x_damage_active == false:
		$ButtonBooster1/Check.hide()
	if Global.booster_plus2HP_active == false:
		$ButtonBooster2/Check.hide()
	if Global.booster_meteor_destroyer_active == false:
		$ButtonBooster3/Check.hide()
	if Global.booster_score_booster_active == false:
		$ButtonBooster4/Check.hide()
	if Global.booster_turret_1_active == false:
		$ButtonBooster5/Check.hide()
	if Global.booster_turret_2_active == false:
		$ButtonBooster6/Check.hide()
	
func _process(_delta: float) -> void:
	refresh_timer()

func refresh_timer():
	if Global.energy == 100:
		$Battery/LabelEnergy.text = tr("_energy_full_main").format({
			"energy": Global.energy
		})
	else:
		$Battery/LabelEnergy.text = tr("_energy_main").format({
			"energy": Global.energy,
			"time": Global.energy_timer
		})
	if Global.energy >= 5:
		$SelectEasy/NoEnergy.hide()
	else:
		$SelectEasy/NoEnergy.show()
		
	if Global.energy >= 10:
		$SelectNormal/NoEnergy.hide()
	else:
		$SelectNormal/NoEnergy.show()
		
	if Global.energy >= 15:
		$SelectHard/NoEnergy.hide()
	else:
		$SelectHard/NoEnergy.show()




func _on_button_back_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_main.tscn")


func _on_button_booster_1_pressed() -> void:
	if Global.booster_2x_damage > 0:
		if Global.booster_2x_damage_active == false:
			Global.booster_2x_damage_active = true
			Sound.get_node("Select").play()	
			$ButtonBooster1/Check.show()
		else:
			Global.booster_2x_damage_active = false
			Sound.get_node("Select2").play()	
			$ButtonBooster1/Check.hide()
	else:
		Sound.get_node("NoEnergy").play()

func _on_button_booster_2_pressed() -> void:
	if Global.booster_plus2HP > 0:
		if Global.booster_plus2HP_active == false:
			Global.booster_plus2HP_active = true
			Sound.get_node("Select").play()	
			$ButtonBooster2/Check.show()
		else:
			Global.booster_plus2HP_active = false
			Sound.get_node("Select2").play()	
			$ButtonBooster2/Check.hide()
	else:
		Sound.get_node("NoEnergy").play()



func _on_button_booster_3_pressed() -> void:
	if Global.booster_meteor_destroyer > 0:
		if Global.booster_meteor_destroyer_active == false:
			Global.booster_meteor_destroyer_active = true
			Sound.get_node("Select").play()	
			$ButtonBooster3/Check.show()
		else:
			Global.booster_meteor_destroyer_active = false
			Sound.get_node("Select2").play()	
			$ButtonBooster3/Check.hide()
	else:
		Sound.get_node("NoEnergy").play()


func _on_button_booster_4_pressed() -> void:
	if Global.booster_score_booster > 0:
		if Global.booster_score_booster_active == false:
			Global.booster_score_booster_active = true
			Sound.get_node("Select").play()	
			$ButtonBooster4/Check.show()
		else:
			Global.booster_score_booster_active = false
			Sound.get_node("Select2").play()	
			$ButtonBooster4/Check.hide()
	else:
		Sound.get_node("NoEnergy").play()


func _on_button_booster_5_pressed() -> void:
	if Global.booster_turret_1 > 0:
		if Global.booster_turret_1_active == false:
			Global.booster_turret_1_active = true
			Sound.get_node("Select").play()	
			$ButtonBooster5/Check.show()
		else:
			Global.booster_turret_1_active = false
			Sound.get_node("Select2").play()	
			$ButtonBooster5/Check.hide()
	else:
		Sound.get_node("NoEnergy").play()

func _on_button_booster_6_pressed() -> void:
	if Global.booster_turret_2 > 0:
		if Global.booster_turret_2_active == false:
			Global.booster_turret_2_active = true
			Sound.get_node("Select").play()	
			$ButtonBooster6/Check.show()
		else:
			Global.booster_turret_2_active = false
			Sound.get_node("Select2").play()	
			$ButtonBooster6/Check.hide()
	else:
		Sound.get_node("NoEnergy").play()
		

func check_boosters_on_click_play():
	if Global.booster_2x_damage_active == true:
		Global.booster_2x_damage -= 1
			
	if Global.booster_plus2HP_active == true:
		Global.booster_plus2HP -= 1
			
	if Global.booster_score_booster_active == true:
		Global.booster_score_booster -= 1
			
	if Global.booster_meteor_destroyer_active == true:
		Global.booster_meteor_destroyer -= 1
			
	if Global.booster_turret_1_active == true:
		Global.booster_turret_1 -= 1
			
	if Global.booster_turret_2_active == true:
		Global.booster_turret_2 -= 1

func _on_button_easy_pressed() -> void:
	if Global.energy >= 5:
		Sound.get_node("Select").play()
		Music.get_node("MusicGameStart").stop()
		Music.get_node("MusicLevel").play()
		await get_tree().create_timer(0.1).timeout
		Global.energy -= 5
		Global.set_level_difficulty = 1
		Global.enemy_counter = 0
		check_boosters_on_click_play()
		get_tree().change_scene_to_file("res://SCENES/scene_level_start.tscn")
	else:
		Sound.get_node("NoEnergy").play()


func _on_button_normal_pressed() -> void:
	if Global.energy >= 10:
		Sound.get_node("Select").play()
		Music.get_node("MusicGameStart").stop()
		Music.get_node("MusicLevel").play()
		await get_tree().create_timer(0.1).timeout
		Global.energy -= 10
		Global.set_level_difficulty = 2
		Global.enemy_counter = 0
		check_boosters_on_click_play()
		get_tree().change_scene_to_file("res://SCENES/scene_level_start.tscn")
	else:
		Sound.get_node("NoEnergy").play()


func _on_button_hard_pressed() -> void:
	if Global.energy >= 15:
		Sound.get_node("Select").play()
		Music.get_node("MusicGameStart").stop()
		Music.get_node("MusicLevel").play()
		await get_tree().create_timer(0.1).timeout
		Global.energy -= 15
		Global.set_level_difficulty = 3
		Global.enemy_counter = 0
		check_boosters_on_click_play()
		get_tree().change_scene_to_file("res://SCENES/scene_level_start.tscn")
	else:
		Sound.get_node("NoEnergy").play()
