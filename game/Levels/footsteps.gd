extends AudioStreamPlayer


func _ready():
	set_volume_db(-80)
	play()


func _on_KinematicBody2D_is_moving(status):
	if status && (get_volume_db() != 0):
		set_volume_db(0)
	elif !status && (get_volume_db() == 0):
		set_volume_db(-80)
