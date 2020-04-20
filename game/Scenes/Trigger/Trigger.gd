extends Area2D
class_name Trigger

export var door : bool = false

signal activated()
signal open_door(cordinates)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func activate():
	emit_signal("activated")
	if door:
		emit_signal("open_door", global_position)
