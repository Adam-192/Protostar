extends Control

var skip : bool = false

func _on_button_language_en_pressed() -> void:
	Sound.get_node("Select2").play()
	TranslationServer.set_locale("en")  # English
	if skip==true:
		get_tree().change_scene_to_file("res://SCENES/scene_tutorial.tscn")
	else:
		get_tree().change_scene_to_file("res://SCENES/scene_intro.tscn")


func _on_button_language_sl_pressed() -> void:
	Sound.get_node("Select2").play()
	TranslationServer.set_locale("sl")  # English
	if skip==true:
		get_tree().change_scene_to_file("res://SCENES/scene_tutorial.tscn")
	else:
		get_tree().change_scene_to_file("res://SCENES/scene_intro.tscn")


func _on_button_skip_pressed() -> void:
	Sound.get_node("Select").play()
	if skip == false:
		skip = true
		$CardX6/ButtonSkip/Check.show()
	else:
		skip = false
		$CardX6/ButtonSkip/Check.hide()


func _on_button_notice_pressed() -> void:
	$Control.hide()
	$ButtonLanguageEN.show()
	$ButtonLanguageSL.show()
	Sound.get_node("Click").play()
