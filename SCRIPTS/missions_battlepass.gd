extends Node


#
# MISSIONS
#

#Kla'ed
var killed_klaedBomber = 0
var killed_klaedScout = 0
var killed_klaedBattlecruiser = 0
var killed_klaedDreadnought = 0
var killed_klaedFighter = 0
var killed_klaedFrigate = 0 

#Nairan
var killed_nairanBomber = 0
var killed_nairanScout = 0
var killed_nairanBattlecruiser = 0
var killed_nairanDreadnought = 0
var killed_nairanFighter = 0
var killed_nairanFrigate = 0

#Nautolan
var killed_nautolanBomber = 0
var killed_nautolanScout = 0
var killed_nautolanBattlecruiser = 0
var killed_nautolanDreadnought = 0
var killed_nautolanFighter = 0
var killed_nautolanFrigate = 0

#
#
#
#
# BATTLE PASS
#

# -1 not unlocked
# 0 unlocked
# 1 calimed

var player_exp = 0

# 0 CADET    1 CAPTAIN    2 ADMIRAl

var cadet_progress = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
var captain_progress = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
var admiral_progress = [-1, -1, -1, -1, -1, -1, -1, -1, -1]

var exp_tier = [100, 300, 650, 1200, 2000, 3000, 4500, 7000, 10000]

func check_exp_progress():
	for i in range(exp_tier.size()):
		# If player has enough total EXP
		if player_exp >= exp_tier[i]:
			# Only unlock if still locked
			if cadet_progress[i] == -1:
				cadet_progress[i] = 0
				
			if captain_progress[i] == -1 and Global.captain_pass == true:
				captain_progress[i] = 0
				
			if admiral_progress[i] == -1 and Global.admiral_pass == true:
				admiral_progress[i] = 0

# # # # # #
# MISSIONS #
# # # # # #
enum MissionType {
	SURVIVE_TIME,
	GET_SCORE,
	KILL_COUNT,
	KILL_COUNT_DIFFICULTY,
	KILL_ENEMY_TYPE
}

const MAX_ACTIVE_MISSIONS := 3

var active_missions: Array = []
var mission_pool: Array = [] # all possible missions

func _ready():
	mission_pool = [
		{
			"id": "survive_60",
			"desc": "_survive_60_desc",
			"type": MissionType.SURVIVE_TIME,
			"target": 60,
			"reward_exp": 100
		},
		{
			"id": "survive_120",
			"desc": "_survive_120_desc",
			"type": MissionType.SURVIVE_TIME,
			"target": 120,
			"reward_exp": 250
		},
		{
			"id": "score_5000",
			"desc": "_score_5000_desc",
			"type": MissionType.GET_SCORE,
			"target": 5000,
			"reward_exp": 350
		},
		{
			"id": "score_2000",
			"desc": "_score_2000_desc",
			"type": MissionType.GET_SCORE,
			"target": 2000,
			"reward_exp": 150
		},
		{
			"id": "kill_20",
			"desc": "_kill_20_desc",
			"type": MissionType.KILL_COUNT,
			"target": 20,
			"reward_exp": 125
		},
		{
			"id": "kill_60",
			"desc": "_kill_60_desc",
			"type": MissionType.KILL_COUNT,
			"target": 60,
			"reward_exp": 375
		},
		{
			"id": "kill_20_fighter",
			"desc": "_kill_20_fighter_desc",
			"type": MissionType.KILL_ENEMY_TYPE,
			"enemy_type": "Fighter",
			"target": 20,
			"reward_exp": 200
		},
		{
			"id": "kill_20_scout",
			"desc": "_kill_20_scout_desc",
			"type": MissionType.KILL_ENEMY_TYPE,
			"enemy_type": "Scout",
			"target": 20,
			"reward_exp": 200
		},
		{
			"id": "kill_5_dreadnought",
			"desc": "_kill_5_dreadnought_desc",
			"type": MissionType.KILL_ENEMY_TYPE,
			"enemy_type": "Dreadnought",
			"target": 5,
			"reward_exp": 200
		},
		{
			"id": "kill_5_battlecruiser",
			"desc": "_kill_5_battlecruiser_desc",
			"type": MissionType.KILL_ENEMY_TYPE,
			"enemy_type": "Battlecruiser",
			"target": 5,
			"reward_exp": 200
		},
		{
			"id": "kill_20_easy",
			"desc": "_kill_20_easy_desc",
			"type": MissionType.KILL_COUNT_DIFFICULTY,
			"difficulty": 1, # EASY
			"target": 20,
			"reward_exp": 50
		},
		{
			"id": "kill_20_normal",
			"desc": "_kill_20_normal_desc",
			"type": MissionType.KILL_COUNT_DIFFICULTY,
			"difficulty": 2, # NORMAL
			"target": 20,
			"reward_exp": 100
		},
		{
			"id": "kill_20_hard",
			"desc": "_kill_20_hard_desc",
			"type": MissionType.KILL_COUNT_DIFFICULTY,
			"difficulty": 3, # HARD
			"target": 20,
			"reward_exp": 150
		},
	]
	
	fill_active_missions()
	
func fill_active_missions():
	while active_missions.size() < MAX_ACTIVE_MISSIONS:
		var new_mission = _create_random_mission()
		if new_mission == null:
			break  # no unique missions left
		active_missions.append(new_mission)

		
func get_available_for_active() -> Array:
	var used_ids := []
	for m in active_missions:
		used_ids.append(m.definition.id)

	var available := []
	for def in mission_pool:
		if not used_ids.has(def.id):
			available.append(def)

	return available

func _create_random_mission():
	var available = get_available_for_active()
	if available.is_empty():
		return null  # no more unique missions to add

	var def = available.pick_random()
	return {
		"definition": def,
		"progress": 0,
		"completed": false,
		"claimed": false
	}
	
func claim_mission(index: int):
	var m = active_missions[index]
	if not m.completed or m.claimed:
		return
	
	m.claimed = true
	player_exp += m.definition.reward_exp
	
	active_missions.remove_at(index)
	fill_active_missions()  # adds a new unique mission

# MISSION -> KILL ENEMY
func on_enemy_killed(enemy_type: String, difficulty: int):
	for m in active_missions:
		if m.completed:
			continue
		
		var def = m.definition
		
		if def.type == MissionType.KILL_COUNT:
			m.progress += 1
			
		elif def.type == MissionType.KILL_ENEMY_TYPE:
			if def.enemy_type == enemy_type:
				m.progress += 1
		
		elif def.type == MissionType.KILL_COUNT_DIFFICULTY:
			if def.difficulty == difficulty:
				m.progress += 1
		
		_check_completion(m)

# MISSION -> SCORE
func on_mission_score(score : int):
	for m in active_missions:
		if m.completed:
			continue
		
		var def = m.definition
		
		if def.type == MissionType.GET_SCORE:
			m.progress += score
		_check_completion(m)
	
# MISSION -> TIME
func on_mission_time():
	for m in active_missions:
		if m.completed:
			continue
		
		var def = m.definition
		
		if def.type == MissionType.SURVIVE_TIME:
			m.progress += 1
		_check_completion(m)

func on_mission_time_reset():
	for m in active_missions:
		if m.completed:
			continue
		
		var def = m.definition
		
		if def.type == MissionType.SURVIVE_TIME:
			m.progress = 0
		_check_completion(m)

func _check_completion(m):
	if m.progress >= m.definition.target:
		m.completed = true

func reset_missions():
	for m in active_missions:
		if m.completed:
			continue
		
		var def = m.definition
		
		if def.type == MissionType.SURVIVE_TIME:
			m.progress = 0


# # # # #
# GIFTS #
# # # # #
func cadet_gift_1():
	if cadet_progress[0] == 0:
		Global.coins += 250
		cadet_progress[0]= 1	

func cadet_gift_2():
	if cadet_progress[1] == 0:
		Global.booster_score_booster += 2
		cadet_progress[1]= 1	

func cadet_gift_3():
	if cadet_progress[2] == 0:
		Global.coins += 600
		cadet_progress[2]= 1	

func cadet_gift_4():
	if cadet_progress[3] == 0:
		Global.common_keys += 2
		cadet_progress[3]= 1	

func cadet_gift_5():
	if cadet_progress[4] == 0:
		Global.coins += 1500
		Global.gems +=50
		cadet_progress[4]= 1	

func cadet_gift_6():
	if cadet_progress[5] == 0:
		Global.rare_keys += 2
		cadet_progress[5]= 1	
		
func cadet_gift_7():
	if cadet_progress[6] == 0:
		Global.booster_2x_damage +=1
		Global.booster_meteor_destroyer +=1
		Global.booster_plus2HP +=1
		Global.booster_score_booster +=1
		Global.booster_turret_1 +=1
		Global.booster_turret_2 +=1
		cadet_progress[6]= 1	
		
func cadet_gift_8():
	if cadet_progress[7] == 0:
		Global.mythical_keys += 1
		cadet_progress[7]= 1	
		
func cadet_gift_9():
	if cadet_progress[8] == 0:
		Global.gems += 199
		cadet_progress[8]= 1	

func captain_gift_1():
	if captain_progress[0] == 0:
		Global.coins += 750
		captain_progress[0]= 1	

func captain_gift_2():
	if captain_progress[1] == 0:
		Global.common_keys += 3
		captain_progress[1]= 1	

func captain_gift_3():
	if captain_progress[2] == 0:
		Global.gems += 115
		captain_progress[2]= 1	

func captain_gift_6():
	if captain_progress[5] == 0:
		Global.coins += 1475
		Global.gems += 75
		captain_progress[5]= 1	

func captain_gift_4():
	if captain_progress[3] == 0:
		Global.booster_2x_damage +=1
		Global.booster_meteor_destroyer +=1
		Global.booster_plus2HP +=1
		Global.booster_score_booster +=1
		Global.booster_turret_1 +=1
		Global.booster_turret_2 +=1
		captain_progress[3]= 1	

func captain_gift_5():
	if captain_progress[4] == 0:
		Global.mythical_keys +=1
		captain_progress[4]= 1	

func captain_gift_8():
	if captain_progress[7] == 0:
		Global.coins += 2500
		Global.gems += 150
		captain_progress[7]= 1	

func captain_gift_7():
	if captain_progress[6] == 0:
		Global.rare_keys += 3
		captain_progress[6]= 1	

func captain_gift_9():
	if captain_progress[8] == 0:
		Global.mythical_keys += 3
		captain_progress[8]= 1	



func admiral_gift_1():
	if admiral_progress[0] == 0:
		Global.common_keys += 1
		Global.rare_keys += 1
		Global.mythical_keys += 1
		admiral_progress[0]= 1	

func admiral_gift_2():
	if admiral_progress[1] == 0:
		Global.coins += 1500
		Global.gems +=150
		admiral_progress[1]= 1	

func admiral_gift_3():
	if admiral_progress[2] == 0:
		Global.common_keys += 15
		admiral_progress[2]= 1	

func admiral_gift_5():
	if admiral_progress[4] == 0:
		Global.booster_2x_damage +=3
		Global.booster_meteor_destroyer +=3
		Global.booster_plus2HP +=3
		Global.booster_score_booster +=3
		Global.booster_turret_1 +=3
		Global.booster_turret_2 +=3
		admiral_progress[4]= 1	

func admiral_gift_4():
	if admiral_progress[3] == 0:
		Global.mythical_keys += 3
		admiral_progress[3]= 1	

func admiral_gift_7():
	if admiral_progress[6] == 0:
		Global.coins += 4000
		Global.gems += 300
		admiral_progress[6]= 1	

func admiral_gift_6():
	if admiral_progress[5] == 0:
		Global.rare_keys += 8
		admiral_progress[5]= 1	

func admiral_gift_8():
	if admiral_progress[7] == 0:
		Global.booster_2x_damage +=5
		Global.booster_meteor_destroyer +=5
		Global.booster_plus2HP +=5
		Global.booster_score_booster +=5
		Global.booster_turret_1 +=5
		Global.booster_turret_2 +=5
		admiral_progress[7]= 1	

func admiral_gift_9():
	if admiral_progress[8] == 0:
		Global.common_keys += 4
		Global.rare_keys += 4
		Global.mythical_keys += 4
		admiral_progress[8]= 1	
