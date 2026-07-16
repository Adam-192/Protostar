extends Node

var music_bus_volume = 0.8
var effects_bus_volume = 0.8

func play_enemy_explosion(is_hard := false):
	$Explosion.play()
	await get_tree().create_timer(0.2).timeout
	$Explosion.play()
	await get_tree().create_timer(0.2).timeout
	$Explosion2.play()

	if is_hard:
		for i in range(5):
			await get_tree().create_timer(0.2).timeout
			$ExplosionPortal.play()

		for i in range(2):
			await get_tree().create_timer(0.2).timeout
			$ExplosionPortal2.play()
