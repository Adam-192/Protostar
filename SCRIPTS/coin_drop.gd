extends Area2D

@export var SPD := 200
var value: int
var picked_up = false

func _ready():
	$Sprite2D.region_rect = Rect2([0,8].pick_random(), [0,8].pick_random(), 8, 8)
	position = Vector2(randi_range(200, 1080), -100)
	if Global.set_level_difficulty == 1:
		value = randi_range(2,40)
	elif Global.set_level_difficulty == 2:
		value = randi_range(25,65)
	elif Global.set_level_difficulty == 3:
		value = randi_range(40, 95)
	else:
		value = 1
	$Label.text = "+"+str(value)
	$Label.hide()

func _process(delta):
	if picked_up == false:
		position.y += SPD * delta
	
	if position.y > 950:
		queue_free()


func _on_body_entered(body):
	if body.is_in_group("group_player") and picked_up==false:
		Global.coins += value
		picked_up = true
		$Label.show()
		$Timer.start()
		$Sprite2D.hide()


func _on_timer_timeout() -> void:
		queue_free()
