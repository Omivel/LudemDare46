extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("Left_click"):
		$Monster.newPath($Navigation2D.get_simple_path($Monster.global_position, get_global_mouse_position()))
		print($Navigation2D.get_simple_path($Monster.global_position, get_global_mouse_position()))
		print($Monster.global_position)
		print(get_global_mouse_position())
