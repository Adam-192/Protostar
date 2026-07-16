extends Control

#
# VAR
#

var current_ship_id : int
var current_ship_skin_id : int

#
# READY
#
func _ready() -> void:
	current_ship_id = Global.selected_ship_id
	current_ship_skin_id = Global.selected_skin_id
	$LabelQuestionmark.hide()
	$CardX2/Skin.texture = PlayerShips.ship_skins[current_ship_id][current_ship_skin_id] 
	refresh_ship_selecter()
#
# FUNC
#
func refresh_ship_selecter():
	check_skin_number()
	show_ships()
	change_ship_skin()
	check_if_skin_unlocked()
	
func show_ships():
	$SpriteSkin.texture =  PlayerShips.ship_skins[current_ship_id][current_ship_skin_id]
	
	var left_id = current_ship_id -1
	if left_id == 0:
		left_id = 14
	
	var right_id = current_ship_id +1
	if right_id == 15:
		right_id = 1
	
	$SpriteSkinL.texture = PlayerShips.ship_skins[left_id][0]
	$SpriteSkinR.texture = PlayerShips.ship_skins[right_id][0]

func change_ship_skin():
	if PlayerShips.ship_skins_unlocked[current_ship_id][0] == 0:
		$SpriteSkin.modulate=Color(0.0, 0.0, 0.0, 1.0)
		$LabelQuestionmark.show()
	else:
		$SpriteSkin.modulate=Color(1.0, 1.0, 1.0, 1.0)
		$LabelQuestionmark.hide()
	$SpriteSkin.texture = PlayerShips.ship_skins[current_ship_id][current_ship_skin_id]

func check_skin_number():
	if current_ship_id < 10:
		$Button_skin6.hide()
		$Button_skin7.hide()
	else:
		$Button_skin6.show()
		$Button_skin7.show()	

func check_if_skin_unlocked():
	if PlayerShips.ship_skins_unlocked[current_ship_id][0] == 1:
		set_button_gradient_color($Button_skin1/Sprite2D, PlayerShips.ship_skins_select_color[current_ship_id][0])
	else:
		set_button_gradient_color($Button_skin1/Sprite2D, Color(0.0, 0.0, 0.0, 1.0))
		
	if PlayerShips.ship_skins_unlocked[current_ship_id][1] == 1:
		set_button_gradient_color($Button_skin2/Sprite2D,  PlayerShips.ship_skins_select_color[current_ship_id][1])
	else:
		set_button_gradient_color($Button_skin2/Sprite2D, Color(0.0, 0.0, 0.0, 1.0))
		
	if PlayerShips.ship_skins_unlocked[current_ship_id][2] == 1:
		set_button_gradient_color($Button_skin3/Sprite2D,  PlayerShips.ship_skins_select_color[current_ship_id][2])
	else:
		set_button_gradient_color($Button_skin3/Sprite2D, Color(0.0, 0.0, 0.0, 1.0))
		
	if PlayerShips.ship_skins_unlocked[current_ship_id][3] == 1:
		set_button_gradient_color($Button_skin4/Sprite2D,  PlayerShips.ship_skins_select_color[current_ship_id][3])
	else:
		set_button_gradient_color($Button_skin4/Sprite2D, Color(0.0, 0.0, 0.0, 1.0))
	
	if PlayerShips.ship_skins_unlocked[current_ship_id][4] == 1:
		set_button_gradient_color($Button_skin5/Sprite2D,  PlayerShips.ship_skins_select_color[current_ship_id][4])
	else:
		set_button_gradient_color($Button_skin5/Sprite2D, Color(0.0, 0.0, 0.0, 1.0))
		
	if current_ship_id>9:
		if PlayerShips.ship_skins_unlocked[current_ship_id][5] == 1:
			set_button_gradient_color($Button_skin6/Sprite2D,  PlayerShips.ship_skins_select_color[current_ship_id][5])
		else:
			set_button_gradient_color($Button_skin6/Sprite2D, Color(0.0, 0.0, 0.0, 1.0))
		if PlayerShips.ship_skins_unlocked[current_ship_id][6] == 1:
			set_button_gradient_color($Button_skin7/Sprite2D,  PlayerShips.ship_skins_select_color[current_ship_id][6])
		else:
			set_button_gradient_color($Button_skin7/Sprite2D, Color(0.0, 0.0, 0.0, 1.0))

func set_button_gradient_color(sprite: Sprite2D, color: Color):
	var grad_tex := sprite.texture as GradientTexture2D
	if grad_tex == null:
		return
	
	grad_tex = grad_tex.duplicate()
	grad_tex.gradient = grad_tex.gradient.duplicate()

	sprite.texture = grad_tex
	grad_tex.gradient.set_color(0, color)
	

#
# BUTTONS
#
func _on_button_back_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_main.tscn")


func _on_button_right_pressed() -> void:
	Sound.get_node("Select").play()
	current_ship_id = current_ship_id+1
	current_ship_skin_id = 0
	if current_ship_id == 15:
		current_ship_id = 1
	refresh_ship_selecter()


func _on_button_left_pressed() -> void:
	Sound.get_node("Select").play()
	current_ship_id = current_ship_id-1
	current_ship_skin_id = 0
	if current_ship_id == 0:
		current_ship_id = 14
	refresh_ship_selecter()


func skin_button_pressed(button_current_ship_skin_id):
	
	change_ship_skin()
	
	var flag = current_ship_skin_id
	current_ship_skin_id = button_current_ship_skin_id
	if PlayerShips.ship_skins_unlocked[current_ship_id][current_ship_skin_id] == 1:
		Sound.get_node("Select2").play()
		change_ship_skin()
	else:
		Sound.get_node("NoEnergy").play()
		current_ship_skin_id = flag
	
func _on_button_skin_1_pressed() -> void:
	skin_button_pressed(0)


func _on_button_skin_2_pressed() -> void:
	skin_button_pressed(1)


func _on_button_skin_3_pressed() -> void:
	skin_button_pressed(2)


func _on_button_skin_4_pressed() -> void:
	skin_button_pressed(3)


func _on_button_skin_5_pressed() -> void:
	skin_button_pressed(4)


func _on_button_skin_6_pressed() -> void:
	skin_button_pressed(5)


func _on_button_skin_7_pressed() -> void:
	skin_button_pressed(6)


func _on_button_select_pressed() -> void:
	
	if PlayerShips.ship_skins_unlocked[current_ship_id][current_ship_skin_id] == 1:
		Sound.get_node("Claim").play()
		Global.selected_ship_id = current_ship_id
		Global.selected_skin_id = current_ship_skin_id
		$CardX2/Skin.texture =  PlayerShips.ship_skins[current_ship_id][current_ship_skin_id]
	else:
		Sound.get_node("NoEnergy").play()
