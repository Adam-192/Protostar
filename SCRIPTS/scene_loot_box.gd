extends Control

func _ready() -> void:
	$CommonLootBox/LabelKeyNum.text = "( "+str(Global.common_keys)+"x )"
	$RareLootBox/LabelKeyNum.text = "( "+str(Global.rare_keys)+"x )"
	$MythicalLootBox/LabelKeyNum.text = "( "+str(Global.mythical_keys)+"x )"
	
	if Global.common_keys <= 0:
		$CommonLootBox/ButtonOpen.disabled = true
		$CommonLootBox/Background2.show()
	if Global.rare_keys <= 0:
		$RareLootBox/ButtonOpen.disabled = true
		$RareLootBox/Background2.show()
	if Global.mythical_keys <= 0:
		$MythicalLootBox/ButtonOpen.disabled = true
		$MythicalLootBox/Background2.show()
		

func _on_button_back_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_main.tscn")


func _on_button_open_pressed_common() -> void:
	Global.common_keys -= 1
	Global.selected_chest_rarety = 1
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/loot_box_opening_scene.tscn")


func _on_button_open_pressed_rare() -> void:
	Global.rare_keys -= 1
	Global.selected_chest_rarety = 2
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/loot_box_opening_scene.tscn")


func _on_button_open_pressed_mythical() -> void:
	Global.mythical_keys -= 1
	Global.selected_chest_rarety = 3
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/loot_box_opening_scene.tscn")
