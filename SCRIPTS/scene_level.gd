extends Control

var current_hp : int
var max_hp : int = 5
var hp_icons: Array[Node] = []

@export var coin_drop_scene = preload("res://SCENES/coin_drop.tscn")

func set_text():
	$Sides/LabelM1.text = str(MissionsBattlepass.active_missions[0].definition.desc)
	$Sides/LabelM2.text = str(MissionsBattlepass.active_missions[1].definition.desc)
	$Sides/LabelM3.text = str(MissionsBattlepass.active_missions[2].definition.desc)
	
	$Pause/LabelM1.text = str(MissionsBattlepass.active_missions[0].definition.desc)
	$Pause/LabelM2.text = str(MissionsBattlepass.active_missions[1].definition.desc)
	$Pause/LabelM3.text = str(MissionsBattlepass.active_missions[2].definition.desc)
	
	$Sides/LabelScore.text = tr("_score")+"\n "+ str(Global.score)
	
	if Global.set_level_difficulty == 1:
		$Sides/LabelDiff.text = tr("_difficulty_easy")
		$Pause/LabelDiff.text = tr("_difficulty_easy")
		$Background/BackgroundEasy.show()
	if Global.set_level_difficulty == 2:
		$Sides/LabelDiff.text = tr("_difficulty_normal")
		$Pause/LabelDiff.text = tr("_difficulty_normal")
		$Background/BackgroundNormal.show()
	if Global.set_level_difficulty == 3:
		$Sides/LabelDiff.text = tr("_difficulty_hard")
		$Pause/LabelDiff.text = tr("_difficulty_hard")
		$Background/BackgroundHard.show()

func _ready() -> void:
	
	if Global.booster_2x_damage_active == true:
		$Sides/LabelBooster1.modulate = Color(1.0, 1.0, 1.0, 1.0)
		
	if Global.booster_plus2HP_active == true:
		$Sides/LabelBooster2.modulate = Color(1.0, 1.0, 1.0, 1.0)
		
	if Global.booster_meteor_destroyer_active == true:
		$Sides/LabelBooster3.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	if Global.booster_score_booster_active == true:
		$Sides/LabelBooster4.modulate = Color(1.0, 1.0, 1.0, 1.0)
		
	if Global.booster_turret_1_active == true:
		$Sides/LabelBooster5.modulate = Color(1.0, 1.0, 1.0, 1.0)
		
	if Global.booster_turret_2_active == true:
		$Sides/LabelBooster6.modulate = Color(1.0, 1.0, 1.0, 1.0)
	
	$Pause.hide()
	if Global.booster_plus2HP_active == true:
		current_hp = 5
	else:
		current_hp = 3
		
	for i in range(1, max_hp + 1):
		hp_icons.append(get_node("HP%d" % i))
	update_hp(current_hp)
	
	$Background/BackgroundEasy.hide()
	$Background/BackgroundNormal.hide()
	$Background/BackgroundHard.hide()
	
	$Timer.start()
	Global.score = 0
	
	if Global.muted == true:
		$Pause/Options/ButtonSound/On.hide()
	else:
		$Pause/Options/ButtonSound/Off.hide()
		
	$Pause/Options/HSliderMusic.value = Sound.music_bus_volume
	$Pause/Options/HSliderEffects.value = Sound.effects_bus_volume
	
	set_text()

func _on_button_pause_pressed() -> void:
	Sound.get_node("Click").play()
	if not get_tree().paused:
		
		$Pause/LabelM1Desc.text =str(MissionsBattlepass.active_missions[0].progress)+ "/"+str(MissionsBattlepass.active_missions[0].definition.target)+"   (+"+str(MissionsBattlepass.active_missions[0].definition.reward_exp)+"exp)"
		$Pause/LabelM2Desc.text =str(MissionsBattlepass.active_missions[1].progress)+ "/"+str(MissionsBattlepass.active_missions[1].definition.target)+"   (+"+str(MissionsBattlepass.active_missions[1].definition.reward_exp)+"exp)"
		$Pause/LabelM3Desc.text =str(MissionsBattlepass.active_missions[2].progress)+ "/"+str(MissionsBattlepass.active_missions[2].definition.target)+"   (+"+str(MissionsBattlepass.active_missions[2].definition.reward_exp)+"exp)"
		
		$Pause/LabelCoins.text = str(Global.coins)
		$Pause/LabelGems.text = str(Global.gems)
		
		Music.get_node("MusicLevel").volume_db=-8.0
		Music.get_node("MusicLevel").pitch_scale = 0.9
		get_tree().paused = true
		$Pause.show()

func update_hp(new_hp: int) -> void:
	current_hp = new_hp
	for i in range(max_hp):
		hp_icons[i].visible = i < new_hp
		
var r_score:int
func _on_timer_timeout() -> void:
	if $Player.HP > 0:
		
		MissionsBattlepass.on_mission_time()
		
		if Global.booster_score_booster_active == true:
			r_score = randi_range(0, 2)
			Global.score += r_score
			MissionsBattlepass.on_mission_score(r_score)
		Global.score += 1
		MissionsBattlepass.on_mission_score(1)
	$Sides/LabelScore.text = tr("_score")+"\n "+ str(Global.score)


func _on_button_continiue_pressed() -> void:
	Sound.get_node("Click").play()
	if get_tree().paused:
		Music.get_node("MusicLevel").volume_db=0.0
		Music.get_node("MusicLevel").pitch_scale = 1.0
		get_tree().paused = false
		$Pause.hide()


func _on_button_destruct_pressed() -> void:
	if get_tree().paused:
		get_tree().paused = false
	Sound.get_node("Click").play()
	Music.get_node("GameOver").play()
	get_tree().change_scene_to_file("res://SCENES/scene_game_over.tscn")


func _on_timer_coin_drop_timeout() -> void:
	$TimerCoinDrop.wait_time = randi_range(10,30)
	var coin_drop = coin_drop_scene.instantiate()
	get_parent().add_child(coin_drop)

###############################################################################
var music_bus = AudioServer.get_bus_index("Music")
var effects_bus = AudioServer.get_bus_index("Effects")

	
func _on_button_sound_pressed() -> void:
	Sound.get_node("Click").play()
	if Global.muted == false:
		Global.sound_on_off()
		$Pause/Options/ButtonSound/On.hide()
		$Pause/Options/ButtonSound/Off.show()
	else:
		Global.sound_on_off()
		$Pause/Options/ButtonSound/Off.hide()
		$Pause/Options/ButtonSound/On.show()


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	Sound.music_bus_volume = value


func _on_h_slider_effects_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(effects_bus, linear_to_db(value))
	Sound.effects_bus_volume = value


func _on_button_test_pressed() -> void:
	Sound.get_node(["Click", "Select", "Select2", "NoEnergy", "Claim", "Buy", "Hit", "Explosion", "Explosion2"].pick_random()).play()

func _on_h_slider_effects_drag_ended(_value_changed: bool) -> void:
	Sound.get_node("Select").play()


func _on_button_language_en_pressed() -> void:
	TranslationServer.set_locale("en")  # English
	set_text()

func _on_button_language_sl_pressed() -> void:
	TranslationServer.set_locale("sl")  # English
	set_text()
