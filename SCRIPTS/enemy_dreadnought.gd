extends CharacterBody2D

###############################################
var HP : int
var SPD = 150

var destination : Vector2

var moving = true
var has_shield = true

var active_laser = null 

var shoot_timer := 0.0
var shoot_interval :float= 999.9

var shield : AnimatedSprite2D
var engine : AnimatedSprite2D
var body : Sprite2D
var destruction : AnimatedSprite2D
var shooting_charging : AnimatedSprite2D
var shooting_laser : AnimatedSprite2D

var explosion_scene = preload("res://SCENES/explosion.tscn")

var bullet_scene := preload("res://SCENES/bullet_laser.tscn")

@export var start_position :Vector2
###############################################

func _ready() -> void:
	position = start_position
	
	if Global.set_level_difficulty == 1:
		$Nautolan.show()
		HP = 15
		shield = $Nautolan/Shield
		engine = $Nautolan/Engine
		body = $Nautolan/Body
		destruction = $Nautolan/Destruction
		shooting_laser = $Nautolan/Shooting_laser
		shooting_charging = $Nautolan/Shooting_charging

	if Global.set_level_difficulty == 2:
		$Klaed.show()
		HP = 20
		shield = $Klaed/Shield
		engine = $Klaed/Engine
		body = $Klaed/Body
		destruction = $Klaed/Destruction
		shooting_laser = $Klaed/Shooting_laser
		shooting_charging = $Klaed/Shooting_charging

	if Global.set_level_difficulty == 3:
		$Nairan.show()
		HP = 30
		shield = $Nairan/Shield
		engine = $Nairan/Engine
		body = $Nairan/Body
		destruction = $Nairan/Destruction
		shooting_laser = $Nairan/Shooting_laser
		shooting_charging = $Nairan/Shooting_charging



func _process(delta):
	if moving:
		position += position.direction_to(destination) * SPD * delta
		
	if position.distance_to(destination) < 5.0 and moving == true:
		moving = false
		deactivate_shield()
		
	shoot_timer += delta
	if shoot_timer >= shoot_interval:
		
		randomize()
		shoot_interval = randf_range(5.0, 10.0) # 5-20
		shoot_timer = 0
		shooting_charging.frame = 0
		shooting_charging.show()
		shooting_charging.play()
		Sound.get_node("LaserCharging").play()

func shoot():
	if has_shield==false and HP > 0:
		Sound.get_node("LaserCharging").stop()
		active_laser = bullet_scene.instantiate()
		active_laser.position = self.position
		get_parent().add_child(active_laser)
		get_parent().move_child(active_laser, 2)  
	
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
	s.stop()
	if active_laser != null:
		active_laser.queue_free()
		active_laser = null
	
	if Global.set_level_difficulty == 1:
		MissionsBattlepass.killed_nautolanDreadnought += 1
		MissionsBattlepass.on_enemy_killed("Dreadnought", 1)
	elif Global.set_level_difficulty == 2:
		MissionsBattlepass.killed_klaedDreadnought += 1
		MissionsBattlepass.on_enemy_killed("Dreadnought", 2)
	else: 
		MissionsBattlepass.killed_nairanDreadnought += 1
		MissionsBattlepass.on_enemy_killed("Dreadnought", 3)
	
	Sound.play_enemy_explosion(Global.set_level_difficulty == 3)
	Global.score+=120
	MissionsBattlepass.on_mission_score(120)
	Global.enemy_counter -= 1
	remove_from_group("group_enemy")
	engine.hide()
	body.hide()
	shooting_laser.hide()
	shooting_charging.hide()
	destruction.show()
	destruction.frame = 0
	destruction.play()

func _on_destruction_animation_finished() -> void:
	queue_free()

var s = Sound.get_node("LaserShooting")
func _on_shooting_charging_animation_finished() -> void:
	s.play()
	shoot()
	shooting_charging.hide()
	shooting_laser.show()
	shooting_laser.play()


func _on_shooting_laser_animation_finished() -> void:
	shooting_laser.hide()
	s.stop()
	if(active_laser!=null):
		active_laser.queue_free()
		active_laser = null
