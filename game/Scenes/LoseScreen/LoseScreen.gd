extends Control

func _ready():
	$music_control.failstate()
	
func _process(delta):
	$music_control.main_stop()
