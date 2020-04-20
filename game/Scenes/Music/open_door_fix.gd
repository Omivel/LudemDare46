extends AudioStreamPlayer
var cycle = 0

func trig():
	if !is_playing():
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
