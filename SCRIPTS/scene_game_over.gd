extends Control

var score : int

func _ready() -> void:
	
	Music.get_node("MusicLevel").volume_db = 0.0
	Music.get_node("MusicLevel").pitch_scale = 0.6
	score = Global.score
	$LabelScore.text = tr("_score")+str(score)
	calculate_exp()
	check_highscore()
	update_mission_info()
	$LabelGold.text = str(Global.coins)
	$LabelGem.text = str(Global.gems)
	MissionsBattlepass.on_mission_time_reset()
	
func check_highscore():
	var diff = Global.set_level_difficulty
	
	if diff == 1:
		$LabelHighScore.text = tr("_highscore")+ str(Global.high_score_easy)
		if Global.high_score_easy < score:
			Global.high_score_easy = score
			$LabelHighScore.text = tr("_highscore")+ str(Global.high_score_easy) + tr("_new")

	elif diff == 2:
		$LabelHighScore.text = tr("_highscore")+ str(Global.high_score_medium)
		if Global.high_score_medium < score:
			Global.high_score_medium = score
			$LabelHighScore.text = tr("_highscore")+str(Global.high_score_medium) + tr("_new")
			
	elif diff == 3:
		$LabelHighScore.text = tr("_highscore")+ str(Global.high_score_hard)
		if Global.high_score_hard< score:
			Global.high_score_hard= score
			$LabelHighScore.text = tr("_highscore")+ str(Global.high_score_hard) + tr("_new")
	
func _on_button_back_pressed() -> void:
	Music.get_node("MusicLevel").volume_db = 0.0
	Music.get_node("MusicLevel").pitch_scale = 1.0
	Music.get_node("MusicLevel").stop()
	Music.get_node("MusicGameStart").play()
	
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_main.tscn")

func calculate_exp():
	var calc_exp:int
	var diff = Global.set_level_difficulty
	
	if diff == 1:
		calc_exp = roundi(float(score)/15 /3)
	elif diff == 2:
		calc_exp = roundi(float(score)/10 /3)
	elif diff == 3:
		calc_exp = roundi(float(score)/6 /3)
		
	$LabelExp.text = "+"+str(calc_exp)+" EXP"
	MissionsBattlepass.player_exp += calc_exp

func update_mission_info():
	$M1info.text = str(MissionsBattlepass.active_missions[0].definition.desc)
	$M1info/Label.text =str(MissionsBattlepass.active_missions[0].progress)+ "/"+str(MissionsBattlepass.active_missions[0].definition.target)+"   (+"+str(MissionsBattlepass.active_missions[0].definition.reward_exp)+"exp)"

	$M2info.text = str(MissionsBattlepass.active_missions[1].definition.desc)
	$M2info/Label.text =str(MissionsBattlepass.active_missions[1].progress)+ "/"+str(MissionsBattlepass.active_missions[1].definition.target)+"   (+"+str(MissionsBattlepass.active_missions[1].definition.reward_exp)+"exp)"

	$M3info.text = str(MissionsBattlepass.active_missions[2].definition.desc)
	$M3info/Label.text =str(MissionsBattlepass.active_missions[2].progress)+ "/"+str(MissionsBattlepass.active_missions[2].definition.target)+"   (+"+str(MissionsBattlepass.active_missions[2].definition.reward_exp)+"exp)"
