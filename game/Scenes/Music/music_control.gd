extends Node2D

func open():
	$open_door.trig()

func close():
	$close_door.trig()

func monster(distance, track_num):
	if track_num == 0: 
		if !$monster_music.is_playing():
			$monster_music.play()
		if !$teethy_licks.is_playing():
			$teethy_licks.play()
		$monster_music.set_volume_db(-distance / 20.0 + 6)
		$teethy_licks.set_volume_db(-distance / 20.0 + 6)
	elif track_num == 1:
		if !$monster2_music.is_playing():
			$monster2_music.play()
		$monster2_music.set_volume_db(-distance / 20.0 + 6)

func footsteps(status):
	if !$footsteps.is_playing():
		$footsteps.play()
	if status && ($footsteps.get_volume_db() != 0):
		$footsteps.set_volume_db(0)
	elif !status && ($footsteps.get_volume_db() == 0):
		$footsteps.set_volume_db(-80)

func failstate():
	if !$fail_sound.is_playing():
		$fail_sound.play()
		$monster_music.stop()
		$main_drone.stop()

func bloop():
	if !$ping.is_playing():
		$ping.play()
	
