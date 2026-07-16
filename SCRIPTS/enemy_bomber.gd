extends CharacterBody2D

###############################################
var HP : int
var SPD : int

var destination :Vector2

var moving = true
var has_shield = true

var shield : AnimatedSprite2D
var engine : AnimatedSprite2D
var body : Sprite2D
var destruction : AnimatedSprite2D

var explosion_scene = preload("res://SCENES/explosion.tscn")

var moving_down = false
var dying = false

@export var start_position :Vector2
###############################################

func _ready() -> void:
	position = start_position
	
	if Global.set_level_difficulty == 1:
		$Nautolan.show()
		HP = 1
		SPD = 250
		shield = $Nautolan/Shield
		engine = $Nautolan/Engine
		body = $Nautolan/Body
		destruction = $Nautolan/Destruction

	if Global.set_level_difficulty == 2:
		$Klaed.show()
		HP = 3
		SPD = 300
		shield = $Klaed/Shield
		engine = $Klaed/Engine
		body = $Klaed/Body
		destruction = $Klaed/Destruction

	if Global.set_level_difficulty == 3:
		$Nairan.show()
		HP = 6
		SPD = 400
		shield = $Nairan/Shield
		engine = $Nairan/Engine
		body = $Nairan/Body
		destruction = $Nairan/Destruction


func _process(delta):
	if moving:
		position += position.direction_to(destination) * SPD * delta
		
	if position.distance_to(destination) < 5.0 and moving == true:
		moving = false
		deactivate_shield()
		
	if moving_down and dying==false:
		position += position.direction_to(Vector2(position.x, position.y+99)) * SPD * delta
		if position.y > 950:
			dying = true
			Global.enemy_counter -= 1
			remove_from_group("group_enemy")
			queue_free()


func deactivate_shield():
	$Timer.start()
	shield.hide()
	has_shield = false
	
func take_damage():
	HP -= 1
	
	var explosion = explosion_scene.instantiate()
	explosion.position = self.position
	explosion.follow = self
	if Global.set_level_difficulty == 3:
		explosion.type = 2
	get_parent().add_child(explosion)
	
	if HP <= 0:
		die()

func die():
	
	if Global.set_level_difficulty == 1:
		MissionsBattlepass.killed_nautolanBomber += 1
		MissionsBattlepass.on_enemy_killed("Bomber", 1)
	elif Global.set_level_difficulty == 2:
		MissionsBattlepass.on_enemy_killed("Bomber", 2)
		MissionsBattlepass.killed_klaedBomber += 1
	else: 
		MissionsBattlepass.killed_nairanBomber += 1
		MissionsBattlepass.on_enemy_killed("Bomber", 3)
	dying = true
	Sound.play_enemy_explosion(Global.set_level_difficulty == 3)
	Global.score+=40
	MissionsBattlepass.on_mission_score(40)
	Global.enemy_counter -= 1
	remove_from_group("group_enemy")
	engine.hide()
	body.hide()
	destruction.show()
	destruction.frame = 0
	destruction.play()

func _on_destruction_animation_finished() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	moving_down = true
