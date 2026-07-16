extends Area2D

var SPD = 400
var HP
var explosion_scene = preload("res://SCENES/explosion.tscn")
var has_shield = false
var pos_y : int = -100

func _ready() -> void:
	randomize()
	HP = randi_range(3,6)
	$Sprite2D.rotate( deg_to_rad(randi_range(0,360)))
	var random_scale = randf_range(2.5, 4.0)
	scale = Vector2(random_scale,random_scale)
	position = (Vector2(randi_range(200,1080),pos_y))
	SPD = randi_range(150,400)


func _process(delta):
	position += position.direction_to(Vector2(position.x, position.y+99)) * SPD * delta
	if position.y > 950:
		queue_free()

func take_damage():
	if Global.booster_meteor_destroyer_active == true:
		HP -= 1
		
		var explosion = explosion_scene.instantiate()
		explosion.position = self.position
		explosion.follow = self
		get_parent().add_child(explosion)
		
		if HP <=0:
			die()
	
func die():
	
	Sound.get_node("Explosion").play()
	Sound.get_node("Explosion2").play()
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("group_player"):
		if body.has_method("take_damage"):
			body.take_damage()
			body.take_damage()
		die()
