extends Control

var music_bus = AudioServer.get_bus_index("Music")
var effects_bus = AudioServer.get_bus_index("Effects")

func _ready() -> void:
	if Global.muted == true:
		$Options/ButtonSound/On.hide()
	else:
		$Options/ButtonSound/Off.hide()
		
	$Options/HSliderMusic.value = Sound.music_bus_volume
	$Options/HSliderEffects.value = Sound.effects_bus_volume
	
func _on_button_sound_pressed() -> void:
	Sound.get_node("Click").play()
	if Global.muted == false:
		$Options/ButtonSound.text = "_unmute_volume"
		Global.sound_on_off()
		$Options/ButtonSound/On.hide()
		$Options/ButtonSound/Off.show()
	else:
		$Options/ButtonSound.text = "_mute_volume"
		Global.sound_on_off()
		$Options/ButtonSound/Off.hide()
		$Options/ButtonSound/On.show()


func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	Sound.music_bus_volume = value


func _on_h_slider_effects_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(effects_bus, linear_to_db(value))
	Sound.effects_bus_volume = value


func _on_button_test_pressed() -> void:
	Sound.get_node(["Click", "Select", "Select2", "NoEnergy", "Claim", "Buy", "Hit", "Explosion", "Explosion2"].pick_random()).play()


func _on_button_back_pressed() -> void:
	Sound.get_node("Click").play()
	get_tree().change_scene_to_file("res://SCENES/scene_main.tscn")


func _on_h_slider_effects_drag_ended(_value_changed: bool) -> void:
	Sound.get_node("Select").play()


func _on_button_language_en_pressed() -> void:
	TranslationServer.set_locale("en")  # English


func _on_button_language_sl_pressed() -> void:
	TranslationServer.set_locale("sl")  # English
