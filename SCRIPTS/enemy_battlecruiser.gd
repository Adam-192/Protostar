extends CharacterBody2D

###############################################
var HP : int
var SPD = 100
var SPD_noShield = 80 #40

var destination :Vector2

var moving = true
var has_shield = true

var shoot_timer := 0.0
var shoot_interval :float= 999.9

var shield : AnimatedSprite2D
var engine : AnimatedSprite2D
var body : Sprite2D
var destruction : AnimatedSprite2D

var explosion_scene = preload("res://SCENES/explosion.tscn")

var bullet_scene := preload("res://SCENES/bullet_wave.tscn")

var direction = 1 # 1 for RIGHT, -1 for LEFT
var dying = false
var moving_left_right = false

#move from to
var left_boundry : int = 0
var right_boundry : int = 0

@export var start_position :Vector2
###############################################

func _ready() -> void:
	position = start_position
	
	if Global.set_level_difficulty == 1:
		$Nautolan.show()
		HP = 10
		shield = $Nautolan/Shield
		engine = $Nautolan/Engine
		body = $Nautolan/Body
		destruction = $Nautolan/Destruction

	if Global.set_level_difficulty == 2:
		$Klaed.show()
		HP = 15
		shield = $Klaed/Shield
		engine = $Klaed/Engine
		body = $Klaed/Body
		destruction = $Klaed/Destruction

	if Global.set_level_difficulty == 3:
		$Nairan.show()
		HP = 25
		shield = $Nairan/Shield
		engine = $Nairan/Engine
		body = $Nairan/Body
		destruction = $Nairan/Destruction


func _process(delta):
	if moving_left_right and dying==false:
		position +=  position.direction_to(Vector2(position.x+(999*direction), position.y)) * SPD * delta
		
		if position.distance_to(Vector2(1280, position.y)) < right_boundry+230:
			direction = -1
			
		if position.distance_to(Vector2(0, position.y)) < left_boundry+230:
			direction = 1
		
	if moving:
		position += position.direction_to(destination) * SPD * delta
		
	if position.distance_to(destination) < 5.0 and moving == true:
		moving = false
		moving_left_right = true
		deactivate_shield()
		
	shoot_timer += delta
	if shoot_timer >= shoot_interval:
		shoot()

func shoot():
	randomize()
	shoot_interval = randf_range(4.0, 8.0) # 5-20
	shoot_timer = 0
	
	if has_shield==false and HP > 0:
		var bullet = bullet_scene.instantiate()
		bullet.position = self.position
		get_parent().add_child(bullet)
	
func deactivate_shield():
	shield.hide()
	has_shield = false
	SPD = SPD_noShield
	shoot_interval = randf_range(2.0, 8.0)
	$Timer_shild_cooldown.start()
	
func take_damage():
	if has_shield == true:
		Sound.get_node("Shield").play()
	if has_shield == false:
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
		MissionsBattlepass.killed_nautolanBattlecruiser += 1
		MissionsBattlepass.on_enemy_killed("Battlecruiser", 1)
	elif Global.set_level_difficulty == 2:
		MissionsBattlepass.killed_klaedBattlecruiser += 1
		MissionsBattlepass.on_enemy_killed("Battlecruiser", 2)
	else: 
		MissionsBattlepass.killed_nairanBattlecruiser += 1
		MissionsBattlepass.on_enemy_killed("Battlecruiser", 3)
	
	Sound.play_enemy_explosion(Global.set_level_difficulty == 3)
	Global.score+=95
	MissionsBattlepass.on_mission_score(95)
	Global.enemy_counter -= 1
	dying = true
	$Timer_shild_cooldown.stop()
	$Timer_shild_duration.stop()
	has_shield = false
	shield.hide()
	remove_from_group("group_enemy")
	engine.hide()
	body.hide()
	destruction.show()
	destruction.frame = 0
	destruction.play()

func _on_destruction_animation_finished() -> void:
	queue_free()


func _on_timer_shild_cooldown_timeout() -> void:
	$Timer_shild_duration.start()
	shield.show()
	has_shield = true


func _on_timer_shild_duration_timeout() -> void:
	$Timer_shild_cooldown.start()
	shield.hide()
	has_shield = false
