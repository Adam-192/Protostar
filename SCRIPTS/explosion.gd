extends Node2D

var type = 1 # NORMAL - RED | 2 - BLUE | 3 - VIOLET 

var follow = null

var random_range = 20
var random_pos_x
var random_pos_y

func _ready() -> void:
	randomize()
	var random_scale = randi_range(2,4)
	scale = Vector2(random_scale, random_scale)
	
	if type == 1:
		$AnimatedExplosion.play()
		$AnimatedExplosion2.hide()
	if type == 2:
		$AnimatedExplosion.hide()
		$AnimatedExplosion2.play()
	
	random_pos_x = randi_range(-random_range, random_range)
	random_pos_y = randi_range(-random_range, random_range)

func _process(_delta: float) -> void:
	if follow != null:
		position = follow.position + Vector2(random_pos_x, random_pos_y)

func _on_animated_explosion_animation_finished() -> void:
	queue_free()
