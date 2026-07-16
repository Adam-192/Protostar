extends Control

func _ready() -> void:
	refresh_currency()
	hide_all()
	refresh_label_num()
	$ButtonBack.show()
	$Default.show()
	
	
	if Global.admiral_pass ==  true:
		$PremiumShop/Button2.disabled = true
	if Global.captain_pass == true:
		$PremiumShop/Button.disabled = true
	
	

func refresh_currency():
	
	$LabelGem.text = str(Global.gems)
	$LabelGold.text = str(Global.coins)
	
	$LabelKeys1.text = tr("_common_keys") + str(Global.common_keys)
	$LabelKeys2.text = tr("_rare_keys") +str(Global.rare_keys)
	$LabelKeys3.text = tr("_mythical_keys")  + str(Global.mythical_keys)
	
	$LabelBooster1Num.text = str(Global.booster_2x_damage)
	$LabelBooster2Num.text = str(Global.booster_plus2HP)
	$LabelBooster3Num.text = str(Global.booster_meteor_destroyer)
	$LabelBooster4Num.text = str(Global.booster_score_booster)
	$LabelBooster5Num.text = str(Global.booster_turret_1)
	$LabelBooster6Num.text = str(Global.booster_turret_2)
	
	refresh_item_avalibilnes()

func refresh_item_avalibilnes():
	var cc = Global.coins # cc -> current coins
	var ge = Global.gems
	var gray :Color= Color(0.471, 0.471, 0.471, 1.0) 
	var white :Color = Color(1.0, 1.0, 1.0, 1.0)
	
	# KEYS
	if cc <450 :
		$BuyKeys/Common/ButtonBack.modulate = gray
	else:
		$BuyKeys/Common/ButtonBack.modulate = white
		
	if cc <1250 :
		$BuyKeys/Common/ButtonBack2.modulate = gray
	else:
		$BuyKeys/Common/ButtonBack2.modulate = white
		
	if cc <950 :
		$BuyKeys/Rare/ButtonBack.modulate = gray
	else:
		$BuyKeys/Rare/ButtonBack.modulate = white
		
	if cc <2500 :
		$BuyKeys/Rare/ButtonBack2.modulate = gray
	else:
		$BuyKeys/Rare/ButtonBack2.modulate = white
		
	if cc <2000 :
		$BuyKeys/Mythical/ButtonBack.modulate = gray
	else:
		$BuyKeys/Mythical/ButtonBack.modulate = white
		
	if cc <5250 :
		$BuyKeys/Mythical/ButtonBack2.modulate = gray
	else:
		$BuyKeys/Mythical/ButtonBack2.modulate = white
	
	# COINS
	if ge < 80:
		$BuyCoins/Button.modulate = gray
	else:
		$BuyCoins/Button.modulate = white
	
	if ge < 350:
		$BuyCoins/Button2.modulate = gray
	else:
		$BuyCoins/Button2.modulate = white
	
	if ge < 750:
		$BuyCoins/Button3.modulate = gray
	else:
		$BuyCoins/Button3.modulate = white
	
	if ge < 2200:
		$BuyCoins/Button4.modulate = gray
	else:
		$BuyCoins/Button4.modulate = white
	
	if ge < 1400:
		$BuyCoins/Button5.modulate = gray
	else:
		$BuyCoins/Button5.modulate = white
		
	# PREMIUM SHOP
	if ge < 100:
		$PremiumShop/Button4.modulate = gray
		$PremiumShop/Button5.modulate = gray
		$PremiumShop/Button6.modulate = gray
	else:
		$PremiumShop/Button4.modulate = white
		$PremiumShop/Button5.modulate = white
		$PremiumShop/Button6.modulate = white
		
	if ge < 350:
		$PremiumShop/Button3.modulate = gray
	else:
		$PremiumShop/Button3.modulate = white
		
		
	if ge < 999:
		$PremiumShop/Button.modulate = gray
	else:
		$PremiumShop/Button.modulate = white
		
		
	if ge < 2450:
		$PremiumShop/Button2.modulate = gray
	else:
		$PremiumShop/Button2.modulate = white
		
	# ENERGY
	var recharge_cost = (300-(Global.energy*3))*4
	if cc < 150:
		$Default/ButtonRecharegeEnergy.modulate = gray
	else:
		$Default/ButtonRecharegeEnergy.modulate = white
		
	if cc < recharge_cost:
		$Default/ButtonRecharegeFullEnergy2.modulate = gray
	else:
		$Default/ButtonRecharegeFullEnergy2.modulate = white
		
	# BOOSTERS
	if cc < 300:
		$BuyBoosters/Button.modulate = gray
	else:
		$BuyBoosters/Button.modulate = white
		
	if cc < 300:
		$BuyBoosters/Button2.modulate = gray
	else:
		$BuyBoosters/Button2.modulate = white
		
	if cc < 500:
		$BuyBoosters/Button3.modulate = gray
	else:
		$BuyBoosters/Button3.modulate = white
		
	if cc < 250:
		$BuyBoosters/Button4.modulate = gray
	else:
		$BuyBoosters/Button4.modulate = white
		
	if cc < 350:
		$BuyBoosters/Button5.modulate = gray
	else:
		$BuyBoosters/Button5.modulate = white
		
	if cc < 500:
		$BuyBoosters/Button6.modulate = gray
	else:
		$BuyBoosters/Button6.modulate = white
		
	

# REFRESH FOR ENERGY
func _process(_delta: float) -> void:
	refresh_timer()

func refresh_label_num():
	$BuyKeys/Common/LabelNum.text = "( "+str(Global.common_keys)+"x )"
	$BuyKeys/Rare/LabelNum.text = "( "+str(Global.rare_keys)+"x )"
	$BuyKeys/Mythical/LabelNum.text = "( "+str(Global.mythical_keys)+"x )"
	
func refresh_timer():
	if Global.energy == 100:
		$Battery/LabelEnergy.text = tr("_energy_full_main").format({
			"energy": Global.energy
		})
	else:
		$Battery/LabelEnergy.text = tr("_energy_main").format({
			"energy": Global.energy,
			"time": Global.energy_timer
		})
		
	var recharge_cost = (300-(Global.energy*3))*4
	$Default/ButtonRecharegeFullEnergy2.text = tr("_full_recharge") + str(recharge_cost) +" "+tr("_shop_gold")

func hide_all():
	$Default.hide()
	$BuyGems.hide()
	$BuyCoins.hide()
	$BuyBoosters.hide()
	$BuyKeys.hide()
	$PremiumShop.hide()
	$ButtonBack.hide()
	$ButtonBack2.hide()

# TO MAIN MENU
func _on_button_back_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_main.tscn")

# TO DEFAULT SHOP
func _on_button_back_2_pressed() -> void:
	Sound.get_node("Click").play()
	hide_all()
	$Default.show()
	$ButtonBack.show()
#
# BUY GEMS
#
func _on_button_pressed_100_gems() -> void:
	Global.gems += 100
	Sound.get_node("Buy").play()
	refresh_currency()


func _on_button_pressed_300_gems() -> void:
	Global.gems += 300
	Sound.get_node("Buy").play()
	refresh_currency()


func _on_button_pressed_3000_gems() -> void:
	Global.gems += 3000
	Sound.get_node("Buy").play()
	refresh_currency()


func _on_button_pressed_9999_gems() -> void:
	Global.gems += 9999
	Sound.get_node("Buy").play()
	refresh_currency()


func _on_button_pressed_1000_gems() -> void:
	Global.gems += 1000
	Sound.get_node("Buy").play()
	refresh_currency()


#
# DEFAULT SCENE
#
func _on_button_buy_gems_pressed() -> void:
	Sound.get_node("Click").play()
	hide_all()
	$BuyGems.show()
	$ButtonBack2.show()


func _on_button_buy_coins_pressed() -> void:
	Sound.get_node("Click").play()
	hide_all()
	$BuyCoins.show()
	$ButtonBack2.show()

func _on_button_buy_keys_pressed() -> void:
	Sound.get_node("Click").play()
	hide_all()
	$BuyKeys.show()
	$ButtonBack2.show()


func _on_button_buy_boosters_pressed() -> void:
	Sound.get_node("Click").play()
	hide_all()
	$BuyBoosters.show()
	$ButtonBack2.show()


func _on_button_premium_shop_pressed() -> void:
	Sound.get_node("Click").play()
	hide_all()
	$PremiumShop.show()
	$ButtonBack2.show()

#
# BUY COINS 
#

func _on_button_pressed_1000_coins() -> void:
	if Global.gems >= 80:
		Global.gems -= 80
		Global.coins+=1000
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_pressed_5000_coins() -> void:
	if Global.gems >= 350:
		Global.gems -= 350
		Global.coins+= 5000
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_pressed_12000_coins() -> void:
	if Global.gems >= 750:
		Global.gems -= 750
		Global.coins+=12000
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_pressed_45000_coins() -> void:
	if Global.gems >= 2200:
		Global.gems -= 2200
		Global.coins+=45000
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_pressed_25000_coins() -> void:
	if Global.gems >= 1400:
		Global.gems -= 1400
		Global.coins+=25000
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


#
# BUY KEYS
#


func _on_button_pressed_1_common() -> void:
	if Global.coins >= 450:
		Global.coins -= 450
		Global.common_keys+=1
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_label_num()
	refresh_currency()


func _on_button_pressed_3_common() -> void:
	if Global.coins >= 1250:
		Global.coins -= 1250
		Global.common_keys+=3
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_label_num()
	refresh_currency()


func _on_button_pressed_1_rare() -> void:
	if Global.coins >= 950:
		Global.coins -= 950
		Global.rare_keys+=1
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_label_num()
	refresh_currency()


func _on_button_pressed_3_rare() -> void:
	if Global.coins >= 2500:
		Global.coins -= 2500
		Global.rare_keys+=3
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_label_num()
	refresh_currency()


func _on_button_pressed_1_mythical() -> void:
	if Global.coins >= 2000:
		Global.coins -= 2000
		Global.mythical_keys+=1
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_label_num()
	refresh_currency()


func _on_button_pressed_3_mythical() -> void:
	if Global.coins >= 5250:
		Global.coins -= 5250
		Global.mythical_keys+=3
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_label_num()
	refresh_currency()

#
# BUY BOOSTERS
#

func _on_button_pressed_booster_1() -> void: # 2x DAMAGE
	if Global.coins >= 300:
		Global.coins -= 300
		Global.booster_2x_damage+=1
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_pressed_booster_2() -> void: # +2 HP
	if Global.coins >= 250:
		Global.coins -= 250
		Global.booster_plus2HP+=1
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_pressed_booster_3() -> void: # METEOR DESTROYER
	if Global.coins >= 300:
		Global.coins -= 300
		Global.booster_meteor_destroyer+=1
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_pressed_booster_4() -> void: # SCORE BOOSTER
	if Global.coins >= 350:
		Global.coins -= 350
		Global.booster_score_booster+=1
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_pressed_booster_5() -> void: # TURRET #1
	if Global.coins >= 500:
		Global.coins -= 500
		Global.booster_turret_1+=1
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_pressed_booster_6() -> void: # TURRET #2
	if Global.coins >= 500:
		Global.coins -= 500
		Global.booster_turret_2+=1
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()

#
# PREMIUM SHOP
#

func _on_button_pressed_exp_boost() -> void:
	if Global.gems >= 350:
		Global.gems -= 350
		MissionsBattlepass.player_exp+=900
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_pressed_captain_pass() -> void:
	if Global.gems >= 999:
		Global.gems -= 999
		Global.captain_pass = true
		$PremiumShop/Button.disabled = true
		Sound.get_node("Buy").play()
		refresh_currency()
	else:
		Sound.get_node("NoEnergy").play()

func _on_button_pressed_admiral_pass() -> void:
	if Global.gems >= 2450:
		Global.gems -= 2450
		Global.admiral_pass = true
		$PremiumShop/Button2.disabled = true
		Sound.get_node("Buy").play()
		refresh_currency()
	else:
		Sound.get_node("NoEnergy").play()

#
# ENERGY REFIL
#

func _on_button_recharege_energy_pressed() -> void:
	if Global.coins >= 150 and  Global.energy < 100:
		Global.coins -=150
		Global.energy +=10
		if Global.energy > 100:
			Global.energy = 100
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()
	refresh_timer()


func _on_button_recharege_full_energy_2_pressed() -> void:
	var recharge_cost = (300-(Global.energy*3))*4
	if Global.coins >= recharge_cost and  Global.energy < 100:
		Global.coins -=recharge_cost
		Global.energy = 100
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()
	refresh_timer()


func _on_button_skip_mission_1() -> void:
	if Global.gems >= 100:
		Global.gems -=100
		MissionsBattlepass.active_missions[0] = MissionsBattlepass.active_missions[2]
		
		MissionsBattlepass.active_missions.remove_at(2)
		MissionsBattlepass.fill_active_missions()
		
		var flag = MissionsBattlepass.active_missions[2]
		MissionsBattlepass.active_missions[2] = MissionsBattlepass.active_missions[0]
		MissionsBattlepass.active_missions[0] = flag
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_skip_mission_2() -> void:
	if Global.gems >= 100:
		Global.gems -=100
		MissionsBattlepass.active_missions[1] = MissionsBattlepass.active_missions[2]
		
		MissionsBattlepass.active_missions.remove_at(2)
		MissionsBattlepass.fill_active_missions()
		
		var flag = MissionsBattlepass.active_missions[2]
		MissionsBattlepass.active_missions[2] = MissionsBattlepass.active_missions[1]
		MissionsBattlepass.active_missions[1] = flag
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_skip_mission_3() -> void:
	if Global.gems >= 100:
		Global.gems -=100
		MissionsBattlepass.active_missions.remove_at(2)
		MissionsBattlepass.fill_active_missions()
		Sound.get_node("Buy").play()
	else:
		Sound.get_node("NoEnergy").play()
	refresh_currency()


func _on_button_open_lootbox_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_loot_box.tscn")
