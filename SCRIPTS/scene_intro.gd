extends Control

var click_counter : int = 0


func _on_button_pressed() -> void:
	click_counter += 1
	check_panel()
	
func check_panel():
	if click_counter == 1:
		$Page1/Intro1.show()
		$Page1/Label1.show()
	if click_counter == 2:
		$Page1/Intro2.show()
		$Page1/Label2.show()
		
	if click_counter == 3:
		$Page1.hide()
		$Page2/Intro3.show()
		$Page2/Label3.show()
	if click_counter == 4:
		$Page2/Intro4.show()
		$Page2/Label4.show()
		
	if click_counter == 5:
		$Page2.hide()
		$Page3/Intro5.show()
		$Page3/Label5.show()
	if click_counter == 6:
		$Page3/Intro6.show()
		$Page3/Label6.show()
		
	if click_counter == 7:
		$Page3.hide()
		$Page4/Intro7.show()
		$Page4/Label7.show()
	if click_counter == 8:
		$Page4/Intro8.show()
		$Page4/Label8.show()
		
	if click_counter == 9:
		$Page4.hide()
		$Page5/Intro9.show()
		$Page5/Label9.show()
	if click_counter == 10:
		$Page5/Intro10.show()
		$Page5/Label10.show()
		
	if click_counter == 11:
		$Page5.hide()
		$Page6/Label11.show()

	if click_counter > 11:
		get_tree().change_scene_to_file("res://SCENES/scene_tutorial.tscn")
		
