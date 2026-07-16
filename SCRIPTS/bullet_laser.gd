extends Area2D

func _ready() -> void:
	if Global.set_level_difficulty ==1: # NAUTOLAN
		$Klaed.hide()
		$Nairan.hide()
	if Global.set_level_difficulty ==2: # KLAED
		$Nairan.hide()
		$Nautolan.hide()
	if Global.set_level_difficulty ==3: # NAIRAN
		$Klaed.hide()
		$Nautolan.hide()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("group_player"):
		if body.has_method("take_damage"):
			body.take_damage()
