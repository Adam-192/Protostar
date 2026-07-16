extends Control

func _ready() -> void:
	$ButtonShip2/Skin.texture = PlayerShips.ship_skins[Global.selected_ship_id][Global.selected_skin_id] 
	
	$LabelGem.text = str(Global.gems)
	$LabelGold.text = str(Global.coins)

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


func _on_button_exit_pressed() -> void:
	Sound.get_node("Click").play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()


func _on_button_shop_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_shop.tscn")


func _on_button_start_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_level_select.tscn")


func _on_button_ship_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_ship.tscn")


func _on_button_missions_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_missions_battlepass.tscn")


func _on_button_lootbox_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_loot_box.tscn")


func _on_button_enemy_list_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_enemy_list.tscn")


func _on_button_credits_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/site_credits.tscn")


func _on_button_options_pressed() -> void:
	Sound.get_node("Click").play()
	
	get_tree().change_scene_to_file("res://SCENES/scene_options.tscn")
