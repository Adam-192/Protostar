extends Node

var fighter_scene : PackedScene
var scout_scene : PackedScene
var frigate_scene : PackedScene
var bomber_scene : PackedScene
var battlecruiser_scene : PackedScene
var dreadnought_scene : PackedScene
var meteor_scene : PackedScene

var wave :int = 0
var wave_spawned :bool = false

func _ready() -> void:
	fighter_scene = preload("res://SCENES/enemy_fighter.tscn")
	scout_scene = preload("res://SCENES/enemy_scout.tscn")
	frigate_scene = preload("res://SCENES/enemy_frigate.tscn")
	bomber_scene = preload("res://SCENES/enemy_bomber.tscn")
	battlecruiser_scene = preload("res://SCENES/enemy_battlecruiser.tscn")
	dreadnought_scene = preload("res://SCENES/enemy_dreadnought.tscn")
	meteor_scene = preload("res://SCENES/enemy_meteor.tscn")

func spawn_enemy(enemy_scene, start_pos, dest_pos, rand :=0, move_from:int=0, move_to:int=0):
	if get_parent()==null:
		return
	if enemy_scene == null:
		return
	Global.enemy_counter += 1
	
	var enemy = enemy_scene.instantiate()
	if enemy_scene == battlecruiser_scene or enemy_scene == frigate_scene:
		enemy.left_boundry = move_from
		enemy.right_boundry = move_to
	enemy.start_position = start_pos
	enemy.destination = dest_pos + Vector2(randi_range(-rand, rand), randi_range(-rand, rand))
	get_parent().add_child(enemy)

func _process(_delta: float) -> void:
	if Global.enemy_counter == 0 and wave_spawned==false:
		wave_spawned = true
		$Timer.start()
		
func _on_timer_timeout() -> void:
	spawn_wave()
####################################################################################################

func spawn_wave():
	wave_spawned = false
	
	var r_meteors = randi_range(1,5) #40% NOTHING
	if r_meteors == 1: # 20%
		meteor_boom()
	if r_meteors == 2: # 20%
		meteor_shower()
	if r_meteors == 3: # 20%
		meteor_ekstra()
		
	var r_bombers = randi_range(1,3) #66% NOTHING
	if r_bombers == 1: # 33%
		bomber_attack()
		
	test_wave()

func call_wave():
	if Global.set_level_difficulty == 1:
		print("CALLING EASY WAVE")
		waves_easy.pick_random().call()
	elif Global.set_level_difficulty == 2:
		print("CALLING NORMAL WAVE")
		waves_medium.pick_random().call()
	elif Global.set_level_difficulty == 3:
		print("CALLING HARD WAVE")
		waves_hard.pick_random().call()


########################################################################
# 0 -   |   ROB-185     SREDINA-640-SREDINA     1095-ROB    |   - 1280 #
########################################################################

var waves_easy = [
	func(): wave_e_01(),
	func(): wave_e_02(),
	func(): wave_e_03(),
	func(): wave_e_04(),
	func(): wave_e_05(),
	func(): wave_e_06(),
	func(): wave_e_07(),
	func(): wave_e_08(),
	func(): wave_e_09(),
]

var waves_medium = [
	func(): wave_m_01(),
	func(): wave_m_02(),
	func(): wave_m_03(),
	func(): wave_m_04(),
	func(): wave_m_05(),
	func(): wave_m_06(),
	func(): wave_m_07(),
	func(): wave_m_08(),
	func(): wave_m_09(),
]

var waves_hard = [
	func(): wave_h_01(),
	func(): wave_h_02(),
	func(): wave_h_03(),
	func(): wave_h_04(),
	func(): wave_h_05(),
	func(): wave_h_06(),
	func(): wave_m_07(),
	func(): wave_m_08(),
	func(): wave_m_09(),
]

func meteor_boom():
	var r = randi_range(-200, -1000)
	for i in range(randi_range(5, 20)):
		spawn_meteor(randi_range(r-100, r+100))
	
func meteor_shower():
	for i in range(randi_range(5, 20)):
		spawn_meteor(-(i*50+100))

func meteor_ekstra():
	for i in range(randi_range(5, 20)):
		spawn_meteor(-(i*500+100))

func bomber_attack():
	for j in range(randi_range(1,3)):
		for i in range(randi_range(5,10)):
			spawn_enemy(bomber_scene, Vector2(640, randi_range(-1000, -50)-((i+1)*200)-((j+1)*500)), Vector2(randi_range(225, 1055), randi_range(30, 250)))

func scout_scouting():	
	for i in range(randi_range(1,4)):
		spawn_enemy(scout_scene, Vector2(640, randi_range(-500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 350)))

func random_small_enemy():
	for i in range(randi_range(1,5)):
		spawn_enemy([fighter_scene, scout_scene,bomber_scene].pick_random(), Vector2(640, randi_range(-500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 350)))


func test_wave():
	call_wave()
	
func wave_h_09():
	for j in range(3):
		for i in range(13):
			spawn_enemy([fighter_scene, scout_scene, bomber_scene].pick_random(), Vector2(640, randi_range(-1000-j*300, -50-j*300)), Vector2(240+i*65, 100+j*100), 10)

func wave_m_09():
	for j in range(2):
		for i in range(13):
			spawn_enemy([fighter_scene, scout_scene, bomber_scene].pick_random(), Vector2(640, randi_range(-1000-j*300, -50-j*300)), Vector2(240+i*65, 100+j*100), 10)

func wave_e_09():
	for j in range(1):
		for i in range(13):
			spawn_enemy([fighter_scene, scout_scene, bomber_scene].pick_random(), Vector2(640, randi_range(-1000-j*300, -50-j*300)), Vector2(240+i*65, 100+j*100), 10)

	
func wave_h_08():
	spawn_enemy([dreadnought_scene, battlecruiser_scene, frigate_scene].pick_random(), Vector2(640, -500), Vector2(640, 80))
	spawn_enemy([dreadnought_scene, battlecruiser_scene, frigate_scene].pick_random(), Vector2(640, -350), Vector2(640, 180))
	spawn_enemy([dreadnought_scene, battlecruiser_scene, frigate_scene].pick_random(), Vector2(640, -100), Vector2(640, 280))
	
	for i in range(7):
		spawn_enemy([fighter_scene, scout_scene, bomber_scene].pick_random(), Vector2(640, randi_range(-100, -50)), Vector2(275+i*130, 350), 10)

func wave_m_08():
	spawn_enemy([dreadnought_scene, battlecruiser_scene, frigate_scene].pick_random(), Vector2(640, -500), Vector2(640, 120))
	spawn_enemy([dreadnought_scene, battlecruiser_scene, frigate_scene].pick_random(), Vector2(640, -100), Vector2(640, 280))
	
	for i in range(7):
		spawn_enemy([fighter_scene, scout_scene, bomber_scene].pick_random(), Vector2(640, randi_range(-100, -50)), Vector2(275+i*130, 350), 10)

func wave_e_08():
	spawn_enemy([dreadnought_scene, battlecruiser_scene, frigate_scene].pick_random(), Vector2(640, -350), Vector2(640, 180))
	
	for i in range(7):
		spawn_enemy([fighter_scene, scout_scene, bomber_scene].pick_random(), Vector2(640, randi_range(-100, -50)), Vector2(275+i*130, 270), 10)

func wave_h_07():
	spawn_enemy(dreadnought_scene, Vector2(640, -250), Vector2(640, 200), 10)
	spawn_enemy(dreadnought_scene, Vector2(640, -50), Vector2(940, 170), 10)
	spawn_enemy(dreadnought_scene, Vector2(640, -50), Vector2(340, 200), 10)
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-2000, -250)-((i+1)*200)), Vector2(randi_range(420, 580), randi_range(30, 150)))
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-2000, -250)-((i+1)*200)), Vector2(randi_range(700, 860), randi_range(30, 150)))
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-1000, -500)-((i+1)*250)), Vector2(randi_range(280, 1000), randi_range(30, 150)))
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-4000, -2000)-((i+1)*200)), Vector2(randi_range(420, 580), randi_range(30, 150)))
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-4000, -2000)-((i+1)*200)), Vector2(randi_range(700, 860), randi_range(30, 150)))
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-4000, -2500)-((i+1)*250)), Vector2(randi_range(280, 1000), randi_range(30, 150)))
	
	
func wave_m_07():
	spawn_enemy(dreadnought_scene, Vector2(640, -50), Vector2(940, 170), 10)
	spawn_enemy(dreadnought_scene, Vector2(640, -50), Vector2(340, 200), 10)
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-2000, -250)-((i+1)*200)), Vector2(randi_range(420, 580), randi_range(30, 150)))
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-2000, -250)-((i+1)*200)), Vector2(randi_range(700, 860), randi_range(30, 150)))

	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-4000, -2000)-((i+1)*200)), Vector2(randi_range(420, 580), randi_range(30, 150)))
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-4000, -2000)-((i+1)*200)), Vector2(randi_range(700, 860), randi_range(30, 150)))
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-4000, -500)-((i+1)*250)), Vector2(randi_range(280, 1000), randi_range(30, 150)))
	
	
func wave_e_07():
	spawn_enemy(dreadnought_scene, Vector2(640, -250), Vector2(640, 200), 10)
	

	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-1000, -500)-((i+1)*250)), Vector2(randi_range(280, 1000), randi_range(30, 150)))
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-4000, -2000)-((i+1)*200)), Vector2(randi_range(420, 580), randi_range(30, 150)))
	
	for i in range(5):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-4000, -2000)-((i+1)*200)), Vector2(randi_range(700, 860), randi_range(30, 150)))


func wave_e_06():
	for i in range(15):
		var e = [bomber_scene, scout_scene, fighter_scene].pick_random()
		spawn_enemy(e, Vector2(640, randi_range(-5500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 350)))

func wave_m_06():
	for i in range(20):
		var e = [bomber_scene, scout_scene, fighter_scene].pick_random()
		spawn_enemy(e, Vector2(640, randi_range(-4500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 350)))


func wave_h_06():
	for i in range(25):
		var e = [bomber_scene, scout_scene, fighter_scene].pick_random()
		spawn_enemy(e, Vector2(640, randi_range(-3500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 350)))

func wave_e_05():
	for i in range(10):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-3500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 250)))
	
	for i in range(8):
		spawn_enemy(scout_scene, Vector2(640, randi_range(-2500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 250)))
		
	
func wave_m_05():
	for i in range(10):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-3500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 250)))
	
	for i in range(10):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-5500, -2500)), Vector2(randi_range(225, 1075), randi_range(50, 250)))
	
	for i in range(10):
		spawn_enemy(fighter_scene, Vector2(640, randi_range(-2500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 250)))
		
	
func wave_h_05():
	for i in range(10):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-3500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 250)))
	
	for i in range(10):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-5500, -2500)), Vector2(randi_range(225, 1075), randi_range(50, 250)))
	
	for i in range(10):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-3500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 250)))
	
	for i in range(10):
		spawn_enemy(fighter_scene, Vector2(640, randi_range(-2500, -50)), Vector2(randi_range(225, 1075), randi_range(50, 250)))
	
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(640, 320), 20)

func wave_e_04():
	for i in range(7):
		spawn_enemy(scout_scene, Vector2(640, randi_range(-100, -50)), Vector2(275+i*130, 70), 20)
	
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(440, 200), 0, 10, 600)
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(640, 200), 0, 350, 350)
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(840, 200), 0, 600, 10)

func wave_h_04():
	for i in range(7):
		spawn_enemy(fighter_scene, Vector2(640, randi_range(-100, -50)), Vector2(275+i*130, 70), 20)
	
	spawn_enemy(battlecruiser_scene, Vector2(640, -50), Vector2(440, 200), 0, 10, 600)
	spawn_enemy(battlecruiser_scene, Vector2(640, -50), Vector2(640, 200), 0, 350, 350)
	spawn_enemy(battlecruiser_scene, Vector2(640, -50), Vector2(840, 200), 0, 600, 10)

func wave_e_03():
	#1 BATTLECRUISER + SCOUTS
	spawn_enemy(battlecruiser_scene, Vector2(640, -50), Vector2(640, 300), 0, 200, 200)

	for i in range(5):
		spawn_enemy(scout_scene, Vector2(640, randi_range(-100, -50)), Vector2(305+i*130, 70), 20)

func wave_m_04():
	# 2 DREADNOUGHT + 1 BATTLECRUISER + SCOUTS
	spawn_enemy(dreadnought_scene, Vector2(640, -50), Vector2(235, 150))
	spawn_enemy(dreadnought_scene, Vector2(640, -50), Vector2(1045, 150))
	spawn_enemy(battlecruiser_scene, Vector2(640, -50), Vector2(640, 300), 0, 200, 200)

	for i in range(5):
		spawn_enemy(scout_scene, Vector2(640, randi_range(-100, -50)), Vector2(305+i*130, 70), 20)
	
func wave_h_03():
	# 2 DREADNOUGHT + 1 BATTLECRUISER + FIGHTERS + SCOUTS
	spawn_enemy(dreadnought_scene, Vector2(640, -50), Vector2(235, 150))
	spawn_enemy(dreadnought_scene, Vector2(640, -50), Vector2(1045, 150))
	spawn_enemy(battlecruiser_scene, Vector2(640, -50), Vector2(640, 300), 0, 200, 200)
	for i in range(11):
		spawn_enemy(fighter_scene, Vector2(640, randi_range(-100, -50)), Vector2(305+i*65, 130), 20)
	for i in range(5):
		spawn_enemy(scout_scene, Vector2(640, randi_range(-100, -50)), Vector2(305+i*130, 70), 20)

func wave_e_02():
	# 2 battlecruiser + frigate
	spawn_enemy(battlecruiser_scene, Vector2(600, -50), Vector2(285, 200))
	spawn_enemy(battlecruiser_scene, Vector2(600, -50), Vector2(995, 200))
	
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(235, 350)) # move on left side

func wave_m_03():
	# 2 battlecruiser + 3 frigate
	spawn_enemy(battlecruiser_scene, Vector2(600, -50), Vector2(285, 200))
	spawn_enemy(battlecruiser_scene, Vector2(600, -50), Vector2(995, 200))
	
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(235, 350)) # move on left side
	
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(235, 50), 0, 100, 500) # move on left side
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(1045, 50), 0, 500, 100) # move on right side
	
func wave_h_02():
	# 2 battlecruiser + 4 frigate + 4 fighter
	
	spawn_enemy(fighter_scene, Vector2(635, -50), Vector2(625, 70), 5)
	spawn_enemy(fighter_scene, Vector2(635, -50), Vector2(625, 130), 5)
	spawn_enemy(fighter_scene, Vector2(675, -50), Vector2(685, 70), 5)
	spawn_enemy(fighter_scene, Vector2(675, -50), Vector2(685, 130), 5)
	
	spawn_enemy(battlecruiser_scene, Vector2(600, -50), Vector2(285, 200))
	spawn_enemy(battlecruiser_scene, Vector2(600, -50), Vector2(995, 200))
	
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(235, 350), 0, 100, 450) # move on left side
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(1045, 350), 0, 450, 100) # move on right side
	
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(235, 50), 0, 100, 500) # move on left side
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(1045, 50), 0, 500, 100) # move on right side

func wave_m_02():
		# 4x frigate + dreadnought # 8 bomber
	for i in range(8):
		spawn_enemy(bomber_scene, Vector2(640, randi_range(-3500, -100)), Vector2(randi_range(225, 1075), randi_range(50, 250)))
		
	spawn_enemy(dreadnought_scene, Vector2(640, -50), Vector2(640, 150))
	
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(235, 350), 0, 100, 450) # move on left side
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(1045, 350), 0, 450, 100) # move on right side
	
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(235, 150), 0, 100, 500) # move on left side
	spawn_enemy(frigate_scene, Vector2(640, -50), Vector2(1045, 150), 0, 500, 100) # move on right side
	
func wave_m_01():
	# 13x fighter
	for i in range(13):
		spawn_enemy(fighter_scene, Vector2(640, randi_range(-100, -50)), Vector2(240+i*65, 130), 20)

func wave_e_01():
	# 13x scout
	for i in range(13):
		spawn_enemy(scout_scene, Vector2(640, randi_range(-100, -50)), Vector2(240+i*65, 130), 20)
	
func wave_h_01():
	# 3x scout -> 12x fighter + dreadnought
	spawn_enemy(scout_scene, Vector2(640, -50), Vector2(640, 60))
	spawn_enemy(scout_scene, Vector2(640, -50), Vector2(600, 40))
	spawn_enemy(scout_scene, Vector2(640, -50), Vector2(680, 40))
	
	spawn_enemy(fighter_scene, Vector2(235, -1050), Vector2(335, 200), 5)
	spawn_enemy(fighter_scene, Vector2(235, -1050), Vector2(335, 250), 5)
	spawn_enemy(fighter_scene, Vector2(265, -1050), Vector2(365, 200), 5)
	spawn_enemy(fighter_scene, Vector2(265, -1050), Vector2(365, 250), 5)
	
	spawn_enemy(fighter_scene, Vector2(1045, -1050), Vector2(945, 200), 5)
	spawn_enemy(fighter_scene, Vector2(1045, -1050), Vector2(945, 250), 5)
	spawn_enemy(fighter_scene, Vector2(1015, -1050), Vector2(915, 200), 5)
	spawn_enemy(fighter_scene, Vector2(1015, -1050), Vector2(915, 250), 5)
	
	spawn_enemy(fighter_scene, Vector2(635, -1050), Vector2(635, 300), 5)
	spawn_enemy(fighter_scene, Vector2(635, -1050), Vector2(635, 350), 5)
	spawn_enemy(fighter_scene, Vector2(675, -1050), Vector2(675, 300), 5)
	spawn_enemy(fighter_scene, Vector2(675, -1050), Vector2(675, 350), 5)
	
	spawn_enemy(dreadnought_scene, Vector2(640, -1350), Vector2(640, 150))

func test_all_enemys():
	spawn_enemy(fighter_scene, Vector2(250, -50), Vector2(250, 250))
	spawn_enemy(fighter_scene, Vector2(250, -50), Vector2(250, 450))
	
	spawn_enemy(scout_scene, Vector2(300, -50), Vector2(300, 250), 50)
	
	spawn_enemy(frigate_scene, Vector2(400, -50), Vector2(400, 150))
	spawn_enemy(frigate_scene, Vector2(400, -50), Vector2(400, 250), 0, 100, 100)
	spawn_enemy(frigate_scene, Vector2(400, -50), Vector2(400, 350), 0, 100, 400) # move on left side
	spawn_enemy(frigate_scene, Vector2(400, -50), Vector2(400, 450), 0, 400, 100) # move on right side
	
	spawn_enemy(bomber_scene, Vector2(500, -50), Vector2(500, 250))
	
	spawn_enemy(battlecruiser_scene, Vector2(600, -50), Vector2(600, 250))
	
	spawn_enemy(dreadnought_scene, Vector2(700, -50), Vector2(700, 250))

func spawn_meteor(pos_y:int=-100):
		var meteor = meteor_scene.instantiate()
		meteor.pos_y = pos_y
		get_parent().add_child(meteor)
		
func _on_meteor_timer_timeout() -> void:
	if Global.set_level_difficulty == 1:
		$MeteorTimer.wait_time = randf_range(5.0, 15.0)
	if Global.set_level_difficulty == 2:
		$MeteorTimer.wait_time = randf_range(3.0, 12.0)
	if Global.set_level_difficulty == 3:
		$MeteorTimer.wait_time = randf_range(1.0, 7.0) # 1-7
	spawn_meteor()


func _on_timer_random_events_timeout() -> void:
	if Global.set_level_difficulty == 1:
		$TimerRandomEvents.wait_time = randf_range(10.0, 16.0)
	elif Global.set_level_difficulty == 2:
		$TimerRandomEvents.wait_time = randf_range(9.0, 14.0)
	elif Global.set_level_difficulty == 3:
		$TimerRandomEvents.wait_time = randf_range(8.0, 12.0)
		
	var r_event = randi_range(1,8)
	print("   CALLING EVENT ", str(r_event))
	print(Global.enemy_counter)
	if r_event == 1:
		meteor_boom()
	if r_event == 2:
		meteor_shower()
	if r_event == 3:
		meteor_ekstra()
	if r_event == 4:
		bomber_attack()
	if r_event == 5:
		pass
	if r_event == 6:
		random_small_enemy()
	if r_event == 7:
		scout_scouting()
	if r_event == 8:
		scout_scouting()
	print(Global.enemy_counter)
