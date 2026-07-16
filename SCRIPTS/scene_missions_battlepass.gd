extends Control

func _ready() -> void:
	
	if Global.captain_pass == false:
		$CaptainPass.hide()
	else:
		$LabelCP_info.hide()
		
	if Global.admiral_pass == false:
		$AdmiralPass.hide()
	else:
		$LabelAP_info.hide()
		
	refresh_all()

func refresh_all():
	# BATTLE PASS
	MissionsBattlepass.check_exp_progress()
	refresh_gifts("Cadet")
	refresh_gifts("Captain")
	refresh_gifts("Admiral")
	update_exp_label()
	
	# MISSIONS
	if MissionsBattlepass.active_missions[0].completed == false: 
		$Mission1/ButtonClaim.disabled = true
	else:
		$Mission1/ButtonClaim.disabled = false
		
	if MissionsBattlepass.active_missions[1].completed == false: 
		$Mission2/ButtonClaim.disabled = true
	else:
		$Mission2/ButtonClaim.disabled = false
		
	if MissionsBattlepass.active_missions[2].completed == false: 
		$Mission3/ButtonClaim.disabled = true
	else:
		$Mission3/ButtonClaim.disabled = false
		
	$Mission1/LabelDesc.text = str(MissionsBattlepass.active_missions[0].definition.desc)
	$Mission2/LabelDesc.text = str(MissionsBattlepass.active_missions[1].definition.desc)
	$Mission3/LabelDesc.text = str(MissionsBattlepass.active_missions[2].definition.desc)
	
	$Mission1/LabelProgress.text = tr("_mission_progress").format({
		"progress": MissionsBattlepass.active_missions[0].progress,
		"target": MissionsBattlepass.active_missions[0].definition.target,
		"exp": MissionsBattlepass.active_missions[0].definition.reward_exp
	})
	$Mission2/LabelProgress.text = tr("_mission_progress").format({
		"progress": MissionsBattlepass.active_missions[1].progress,
		"target": MissionsBattlepass.active_missions[1].definition.target,
		"exp": MissionsBattlepass.active_missions[1].definition.reward_exp
	})
	$Mission3/LabelProgress.text = tr("_mission_progress").format({
		"progress": MissionsBattlepass.active_missions[2].progress,
		"target": MissionsBattlepass.active_missions[2].definition.target,
		"exp": MissionsBattlepass.active_missions[2].definition.reward_exp
	})



func _on_button_back_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_main.tscn")

func refresh_gifts(pass_name: String) -> void:
	var get_progress: Array
	var path: Node

	match pass_name:
		"Cadet":
			get_progress = MissionsBattlepass.cadet_progress
			path = $CadetPass
		"Captain":
			get_progress = MissionsBattlepass.captain_progress
			path = $CaptainPass
		"Admiral":
			get_progress = MissionsBattlepass.admiral_progress
			path = $AdmiralPass
		_:
			return

	for i in range(get_progress.size()):
		var progress: int = get_progress[i]
		var gift_button := path.get_node_or_null("Gift%d" % (i + 1)) as Button
		if gift_button == null:
			continue

		match progress:
			-1: # locked
				gift_button.disabled = true
				gift_button.modulate = Color(0.883, 0.517, 0.545)
			0: # unlocked, not claimed
				gift_button.disabled = false
				gift_button.modulate = Color.WHITE
			1: # claimed
				gift_button.disabled = true
				gift_button.modulate = Color(0.14, 0.222, 0.193)
#
# BATTLE PASS GIFTS 
#

func _on_gift_1_pressed_Cadet() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.cadet_gift_1()
	refresh_gifts("Cadet")

func _on_gift_2_pressed_Cadet() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.cadet_gift_2()
	refresh_gifts("Cadet")


func _on_gift_3_pressed_Cadet() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.cadet_gift_3()
	refresh_gifts("Cadet")


func _on_gift_4_pressed_Cadet() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.cadet_gift_4()
	refresh_gifts("Cadet")


func _on_gift_5_pressed_Cadet() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.cadet_gift_5()
	refresh_gifts("Cadet")


func _on_gift_6_pressed_Cadet() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.cadet_gift_6()
	refresh_gifts("Cadet")


func _on_gift_7_pressed_Cadet() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.cadet_gift_7()
	refresh_gifts("Cadet")


func _on_gift_8_pressed_Cadet() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.cadet_gift_8()
	refresh_gifts("Cadet")


func _on_gift_9_pressed_Cadet() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.cadet_gift_9()
	refresh_gifts("Cadet")

func _on_gift_1_pressed_Captain() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.captain_gift_1()
	refresh_gifts("Captain")

func _on_gift_2_pressed_Captain() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.captain_gift_2()
	refresh_gifts("Captain")

func _on_gift_3_pressed_Captain() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.captain_gift_3()
	refresh_gifts("Captain")

func _on_gift_4_pressed_Captain() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.captain_gift_4()
	refresh_gifts("Captain")

func _on_gift_5_pressed_Captain() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.captain_gift_5()
	refresh_gifts("Captain")

func _on_gift_6_pressed_Captain() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.captain_gift_6()
	refresh_gifts("Captain")

func _on_gift_7_pressed_Captain() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.captain_gift_7()
	refresh_gifts("Captain")

func _on_gift_8_pressed_Captain() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.captain_gift_8()
	refresh_gifts("Captain")

func _on_gift_9_pressed_Captain() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.captain_gift_9()
	refresh_gifts("Captain")

func _on_gift_1_pressed_Admiral() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.admiral_gift_1()
	refresh_gifts("Admiral")

func _on_gift_2_pressed_Admiral() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.admiral_gift_2()
	refresh_gifts("Admiral")

func _on_gift_3_pressed_Admiral() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.admiral_gift_3()
	refresh_gifts("Admiral")

func _on_gift_4_pressed_Admiral() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.admiral_gift_4()
	refresh_gifts("Admiral")

func _on_gift_5_pressed_Admiral() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.admiral_gift_5()
	refresh_gifts("Admiral")

func _on_gift_6_pressed_Admiral() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.admiral_gift_6()
	refresh_gifts("Admiral")

func _on_gift_7_pressed_Admiral() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.admiral_gift_7()
	refresh_gifts("Admiral")

func _on_gift_8_pressed_Admiral() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.admiral_gift_8()
	refresh_gifts("Admiral")

func _on_gift_9_pressed_Admiral() -> void:
	Sound.get_node("Claim").play()
	MissionsBattlepass.admiral_gift_9()
	refresh_gifts("Admiral")

#
# EXP + MISSIONS
#
func update_exp_label() -> void:
	var total_levels: int = MissionsBattlepass.exp_tier.size()
	var current_level: int = 0

	# Count unlocked tiers
	for p in MissionsBattlepass.cadet_progress:
		if p != -1:
			current_level += 1

	# MAX LEVEL
	if current_level >= total_levels:
		var max_exp: int = MissionsBattlepass.exp_tier[total_levels - 1]
		$LabelExpProgress.text = tr("_level_max").format({
			"current": total_levels,
			"total": total_levels,
			"xp": MissionsBattlepass.player_exp,
			"max_xp": max_exp
		})
		return

	# ---- NEXT LEVEL (relative) ----
	var prev_exp: int = 0 if current_level == 0 else MissionsBattlepass.exp_tier[current_level - 1]
	var next_exp: int = MissionsBattlepass.exp_tier[current_level]
	var needed_exp: int = next_exp - prev_exp
	var current_exp: int = clamp(MissionsBattlepass.player_exp - prev_exp, 0, needed_exp)

	var percent: int = 0
	if needed_exp > 0:
		percent = int((float(current_exp) / needed_exp) * 100.0)

	# ---- TOTAL ----
	var total_current: int = clamp(MissionsBattlepass.player_exp, 0, next_exp)
	var total_needed: int = next_exp

	$LabelExpProgress.text = tr("_level_progress").format({
		"current": current_level,
		"total": total_levels,
		"cur_exp": current_exp,
		"need_exp": needed_exp,
		"percent": percent,
		"total_cur": total_current,
		"total_need": total_needed
	})


func _on_button_m_1_pressed() -> void:
	Sound.get_node("Claim").play()
	if MissionsBattlepass.active_missions[0].completed == true:
		MissionsBattlepass._check_completion(MissionsBattlepass.active_missions[0])
		MissionsBattlepass.claim_mission(0)
		refresh_all()


func _on_button_m_2_pressed() -> void:
	Sound.get_node("Claim").play()
	if MissionsBattlepass.active_missions[1].completed == true:
		MissionsBattlepass._check_completion(MissionsBattlepass.active_missions[1])
		MissionsBattlepass.claim_mission(1)
		refresh_all()


func _on_button_m_3_pressed() -> void:
	Sound.get_node("Claim").play()
	if MissionsBattlepass.active_missions[2].completed == true:
		MissionsBattlepass._check_completion(MissionsBattlepass.active_missions[2])
		MissionsBattlepass.claim_mission(2)
		refresh_all()
