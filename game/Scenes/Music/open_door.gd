extends AudioStreamPlayer
var cycle = 0

func _on_TestLevel_door(status):
	if !is_playing() && status:
		if cycle == 0:
			$one.play()
			$one.set_volume_db(-5 * randf() + 3)
			cycle += 1
		elif cycle == 1:
			$two.play()
			$two.set_volume_db(-5 * randf() + 3)
			cycle += 1
		elif cycle == 2:
			$three.play()
			$three.set_volume_db(-5 * randf() + 3)
			cycle += 1
		else:
			play()
			set_volume_db(-5 * randf() + 3)
			cycle = 0
