extends Node2D

func open():
	$open_door.trig()

func close():
	$close_door.trig()

func monster(distance, track_num):
	if !$monster_music.is_playing():
		$monster_music.play()
	if !track_num: #if track_num == 0, I'm just being cheeky here rn
		$monster_music.set_volume_db(-distance / 20.0 + 6)
	elif track_num:
		$monster2_music.set_volume_db(-distance / 20.0 + 6)

func footsteps(status):
	if !$footsteps.is_playing():
		$footsteps.play()
	if status && ($footsteps.get_volume_db() != 0):
		$footsteps.set_volume_db(0)
	elif !status && ($footsteps.get_volume_db() == 0):
		$footsteps.set_volume_db(-80)

func failstate(status):
	if !$fail_sound.is_playing() && status:
		$fail_sound.play()
		$monster_music.stop()
		$main_drone.stop()
	
