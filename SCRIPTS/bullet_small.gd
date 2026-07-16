extends Area2D

var speed := 350.0

func _ready() -> void:
	Sound.get_node("ShootingSmall").play()
	$Nautolan.hide()
	$Klaed.hide()
	$Nairan.hide()
	if Global.set_level_difficulty == 1:
		$Nautolan.show()
	if Global.set_level_difficulty == 2:
		$Klaed.show()
	if Global.set_level_difficulty == 3:
		$Nairan.show()

func _process(delta):
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("group_player"):
		if body.has_method("take_damage"):
			body.take_damage()
		queue_free()
