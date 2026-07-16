extends Area2D

@export var speed :float= 400.0

func _ready() -> void:
	Sound.get_node("PlayerShooting").play()

func _process(delta: float) -> void:
	position.y -= speed * delta
	
	if position.y < -10:
		queue_free()

func destroy_bullet():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("group_enemy"):
		if body.has_shield == false:
			var hits = [
				Sound.get_node("Hit"),
				Sound.get_node("Hit2"),
				Sound.get_node("Hit3")
			]
			hits.pick_random().play()
			body.take_damage()
		else:
			Sound.get_node("Shield").play()
		destroy_bullet()


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("group_enemy"):
		if area.has_shield == false:
			var hits = [
				Sound.get_node("Hit"),
				Sound.get_node("Hit2"),
				Sound.get_node("Hit3")
			]
			hits.pick_random().play()
			area.take_damage()
		else:
			Sound.get_node("Shield").play()
		destroy_bullet()
