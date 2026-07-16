extends CharacterBody2D

@export var bullet_scene = preload("res://SCENES/player_bullet.tscn")

func destroy():
	queue_free()

func _on_timer_timeout() -> void:
	randomize()
	$Timer.wait_time = randi_range(1, 3)
	
	shoot()
	
func shoot():
	var bullet = bullet_scene.instantiate()
	bullet.global_position = global_position + Vector2(0, -20)
	get_tree().current_scene.add_child(bullet)
