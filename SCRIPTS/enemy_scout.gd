extends CharacterBody2D

###############################################
var HP : int
var SPD = 300

var destination : Vector2

var moving = true
var has_shield = true

var shoot_timer := 0.0
var shoot_interval :float= 999.9

var shield : AnimatedSprite2D
var engine : AnimatedSprite2D
var body : Sprite2D
var destruction : AnimatedSprite2D

var explosion_scene = preload("res://SCENES/explosion.tscn")

var bullet_scene := preload("res://SCENES/bullet_small.tscn")

@export var start_position :Vector2
###############################################

func _ready() -> void:
	position = start_position
	
	if Global.set_level_difficulty == 1:
		$Nautolan.show()
		HP = 3
		shield = $Nautolan/Shield
		engine = $Nautolan/Engine
		body = $Nautolan/Body
		destruction = $Nautolan/Destruction

	if Global.set_level_difficulty == 2:
		$Klaed.show()
		HP = 5
		shield = $Klaed/Shield
		engine = $Klaed/Engine
		body = $Klaed/Body
		destruction = $Klaed/Destruction

	if Global.set_level_difficulty == 3:
		$Nairan.show()
		HP = 8
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
		
	shoot_timer += delta
	if shoot_timer >= shoot_interval:
		shoot()

func shoot():
	randomize()
	shoot_interval = randf_range(6.0, 10.0)
	shoot_timer = 0
	
	if has_shield==false and HP > 0:
		var bullet = bullet_scene.instantiate()
		bullet.position = self.position
		get_parent().add_child(bullet)
	
func deactivate_shield():
	shield.hide()
	has_shield = false
	shoot_interval = randf_range(2.0, 8.0)
	
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
		MissionsBattlepass.killed_nautolanScout += 1
		MissionsBattlepass.on_enemy_killed("Scout", 1)
	elif Global.set_level_difficulty == 2:
		MissionsBattlepass.killed_klaedScout += 1
		MissionsBattlepass.on_enemy_killed("Scout", 2)
	else: 
		MissionsBattlepass.killed_nairanScout += 1
		MissionsBattlepass.on_enemy_killed("Scout", 3)
	
	Sound.play_enemy_explosion(Global.set_level_difficulty == 3)
	Global.score+=25
	MissionsBattlepass.on_mission_score(25)
	Global.enemy_counter -= 1
	remove_from_group("group_enemy")
	engine.hide()
	body.hide()
	destruction.show()
	destruction.frame = 0
	destruction.play()

func _on_destruction_animation_finished() -> void:
	queue_free()
