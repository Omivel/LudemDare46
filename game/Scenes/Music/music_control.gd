extends Node2D


func open():
	$open_door.trig()

func close():
	$close_door.trig()
	
func fade():
	$main_drone.startready()

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
	if status:# && ($footsteps.get_volume_db() < 0):
		$footsteps.set_volume_db(18)
	elif !status:# && ($footsteps.get_volume_db() > 0):
		$footsteps.set_volume_db(-80)

func failstate():
	$fail_sound.stop()
	$fail_sound.set_volume_db(10)
	$fail_sound.play()
	$main_drone.set_volume_db(-80)
	$monster_music.stop()
	$footsteps.stop()
		
func winstate():
	$fail_sound.stop()
	$winstate.set_volume_db(10)
	$winstate.play()
	$main_drone.set_volume_db(-80)
	$monster_music.stop()
	$footsteps.stop()

func main_stop():
	$main_drone.stop()

func bloop():
	if !$click.is_playing():
		$click.play()
		
func is_playing_main():
	return $main_drone.is_playing()
