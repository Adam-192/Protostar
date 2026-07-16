extends Node

#
#
#
var muted = false

var coins : int = 0
var gems : int = 0

var common_keys = 3
var rare_keys = 2
var mythical_keys = 0
var selected_chest_rarety : int

var energy = 35

var selected_ship_id = 7 # 1-14
var selected_skin_id = 0 # 0-4 / 0-6

# ENERGY
var energy_timer =10
var energy_timer_time = 30
var timer = Timer.new()  
#
func on_timer_timeout() -> void:
	if energy == 100:
		energy_timer = energy_timer_time
		
	elif energy<100:
		energy_timer-=1
		
	if energy_timer<1:
		energy_timer = energy_timer_time
		energy+=1
#
# ON START
#

func _ready() -> void:
	
	add_child(timer)  
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(on_timer_timeout)
	timer.start(1)
	
	if muted == true:
		AudioServer.set_bus_mute(bus_idx, true) # SOUNDS ON
	else:
		AudioServer.set_bus_mute(bus_idx, false) # SOUNDS OFF - MUTE

#
# SOUND MIXER
#
var bus_idx = AudioServer.get_bus_index("Master")
func sound_on_off():
	if muted == true:
		AudioServer.set_bus_mute(bus_idx, false) # SOUNDS ON
		muted = false
	else:
		AudioServer.set_bus_mute(bus_idx, true) # SOUNDS OFF - MUTE
		muted = true
#
# LEVELS
#
var set_level_difficulty : int #1 EASY 2 MEDIUM 3 HARD
var enemy_counter : int = 0

var score : int = 0
var high_score_easy := 0
var high_score_medium := 0
var high_score_hard := 0

#
#
# PASS
var captain_pass = false
var admiral_pass = false
#
#
# BOOSTERS
var booster_2x_damage = 2
var booster_plus2HP = 1
var booster_meteor_destroyer = 4
var booster_score_booster = 3
var booster_turret_1 = 5
var booster_turret_2 = 6

var booster_2x_damage_active = false
var booster_plus2HP_active = false
var booster_meteor_destroyer_active = false
var booster_score_booster_active = false
var booster_turret_1_active = false
var booster_turret_2_active = false

###
