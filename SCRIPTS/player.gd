extends CharacterBody2D

var SPD : float

@export var normal_speed := 350.0
@export var slow_speed := 200.0

@export var screen_margin_width := 220.0
@export var screen_margin_height := 25.0

@export var bullet_scene = preload("res://SCENES/player_bullet.tscn")

var screen_size : Vector2

var HP :int = 99

var dying = false
var death_pos : Vector2

func _ready() -> void:
	if Global.booster_plus2HP_active == true:
		HP = 5
	else:
		HP = 3
	screen_size = get_viewport_rect().size
	$Skin.texture = PlayerShips.ship_skins[Global.selected_ship_id][Global.selected_skin_id]
	
	if (Global.selected_ship_id > 9):
		$Skin.scale = Vector2(1.4, 1.4)
	else:
		$Skin.scale = Vector2(1.0, 1.0)
	
	if Global.booster_turret_1_active == false:
		$Turret1.destroy()
	if Global.booster_turret_2_active == false:
		$Turret2.destroy()
		
	SPD = normal_speed

############### MOVEMENT ############### MOVEMENT ############### MOVEMENT ############### MOVEMENT ###############
func _physics_process(_delta: float) -> void:
	if dying == true:
		return
	var input_vector := Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	# Normalize so diagonal isn't faster
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized()

	velocity = input_vector * SPD
	move_and_slide()

	# Clamp inside screen
	position.x = clamp(position.x, screen_margin_width, screen_size.x - screen_margin_width)
	position.y = clamp(position.y, screen_margin_height, screen_size.y - screen_margin_height)
################################################################################################################

############### SHOOTING ############### SHOOTING ############### SHOOTING ############### SHOOTING #############
func _process(_delta):
	if dying:
		return
		
	if Input.is_action_just_released("shoot"):
		shoot()
		
	#if Input.is_action_pressed("move_slow"):
	#	SPD = slow_speed
	#else:
	#	SPD = normal_speed
	#	$FireTimer.stop()
		
	#if Input.is_action_pressed("shoot"):
		#SPD = slow_speed
		#if $FireTimer.is_stopped():
			#$FireTimer.start()
	#elif Input.is_action_pressed("move_slow"):
		#SPD = slow_speed
	#else:
		#SPD = normal_speed
		#$FireTimer.stop()

func shoot():
	if dying == true:
		return
	
	if Global.booster_2x_damage_active == false:
		var bullet = bullet_scene.instantiate()
		bullet.global_position = global_position + Vector2(0, -20)
		get_parent().add_child(bullet)
	else:
		var bullet1 = bullet_scene.instantiate()
		bullet1.global_position = global_position + Vector2(-20, -20)
		get_parent().add_child(bullet1)
		var bullet2 = bullet_scene.instantiate()
		bullet2.global_position = global_position + Vector2(+20, -20)
		get_parent().add_child(bullet2)
################################################################################################################

func take_damage():
	if HP > 0: 
		HP -= 1
	get_parent().update_hp(HP)
	
	if HP <= 0 and dying == false:
		dying = true
		if Global.booster_turret_1_active==true:
			$Turret1.destroy()
		if Global.booster_turret_2_active==true:
			$Turret2.destroy()
		death_pos = $DeathAnimation.position
		$DeathAnimation.show()
		$DeathTimer.start()
	
	
func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("group_enemy"):
		body.die()
		
		take_damage()
		take_damage()

func die():
	Music.get_node("GameOver").play()
	get_tree().change_scene_to_file("res://SCENES/scene_game_over.tscn")


func _on_death_timer_timeout() -> void:
	die()


func _on_death_explosions_1_animation_looped() -> void:
	if dying==true:
		Sound.get_node("Explosion").play()
		Sound.get_node("Explosion2").play()
		$DeathAnimation/DeathExplosions1.position = death_pos + Vector2(randi_range(-40,40), randi_range(-40,40))
		$DeathAnimation/DeathExplosions2.position = death_pos + Vector2(randi_range(-40,40), randi_range(-40,40))
		$DeathAnimation/DeathExplosions3.position = death_pos + Vector2(randi_range(-40,40), randi_range(-40,40))
