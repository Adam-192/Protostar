extends Control

func set_destroyed_label(path: String, count: int):
	var label = get_node(path)
	label.text = tr("_destroyed_label").format({
		"count": count
	})
func _ready() -> void:
	$ButtonNormal.grab_focus()

	# Klaed Normal
	set_destroyed_label("Klaed_Normal/ScoutBase/LabelDestroyed", MissionsBattlepass.killed_klaedScout)
	set_destroyed_label("Klaed_Normal/BomberBase/LabelDestroyed", MissionsBattlepass.killed_klaedBomber)
	set_destroyed_label("Klaed_Normal/DreadnoughtBase/LabelDestroyed", MissionsBattlepass.killed_klaedDreadnought)
	set_destroyed_label("Klaed_Normal/FighterBase/LabelDestroyed", MissionsBattlepass.killed_klaedFighter)
	set_destroyed_label("Klaed_Normal/FrigateBase/LabelDestroyed", MissionsBattlepass.killed_klaedFrigate)
	set_destroyed_label("Klaed_Normal/BattlecruiserBase/LabelDestroyed", MissionsBattlepass.killed_klaedBattlecruiser)

	# Nairan Hard
	set_destroyed_label("Nairan_Hard/ScoutBase/LabelDestroyed", MissionsBattlepass.killed_nairanScout)
	set_destroyed_label("Nairan_Hard/BomberBase/LabelDestroyed", MissionsBattlepass.killed_nairanBomber)
	set_destroyed_label("Nairan_Hard/DreadnoughtBase/LabelDestroyed", MissionsBattlepass.killed_nairanDreadnought)
	set_destroyed_label("Nairan_Hard/FighterBase/LabelDestroyed", MissionsBattlepass.killed_nairanFighter)
	set_destroyed_label("Nairan_Hard/FrigateBase/LabelDestroyed", MissionsBattlepass.killed_nairanFrigate)
	set_destroyed_label("Nairan_Hard/BattlecruiserBase/LabelDestroyed", MissionsBattlepass.killed_nairanBattlecruiser)

	# Nautolan Easy
	set_destroyed_label("Nautolan_Easy/ScoutBase/LabelDestroyed", MissionsBattlepass.killed_nautolanScout)
	set_destroyed_label("Nautolan_Easy/BomberBase/LabelDestroyed", MissionsBattlepass.killed_nautolanBomber)
	set_destroyed_label("Nautolan_Easy/DreadnoughtBase/LabelDestroyed", MissionsBattlepass.killed_nautolanDreadnought)
	set_destroyed_label("Nautolan_Easy/FighterBase/LabelDestroyed", MissionsBattlepass.killed_nautolanFighter)
	set_destroyed_label("Nautolan_Easy/FrigateBase/LabelDestroyed", MissionsBattlepass.killed_nautolanFrigate)
	set_destroyed_label("Nautolan_Easy/BattlecruiserBase/LabelDestroyed", MissionsBattlepass.killed_nautolanBattlecruiser)


func hide_all():
	$Klaed_Normal.hide()
	$Nautolan_Easy.hide()
	$Nairan_Hard.hide()

func _on_button_easy_pressed() -> void:
	Sound.get_node("Click").play()
	hide_all()
	$Nautolan_Easy.show()


func _on_button_normal_pressed() -> void:
	Sound.get_node("Click").play()
	hide_all()
	$Klaed_Normal.show()


func _on_button_hard_pressed() -> void:
	Sound.get_node("Click").play()
	hide_all()
	$Nairan_Hard.show()


func _on_button_back_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_main.tscn")
