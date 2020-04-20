extends Area2D
class_name Trigger
tool

export var open : bool = true
export var door : bool = false
export var pressable : bool = true

var animated_sprite = null

signal activated()
signal not_door()
signal open_door(cordinates)

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if child is AnimatedSprite:
			animated_sprite = child
			if open:
				child.frame = 19
			else:
				child.frame = 0

func _process(delta):
	if Engine.editor_hint:
		if door and animated_sprite != null:
			if open and animated_sprite.frame != 19:
				animated_sprite.frame = 19
			elif !open and animated_sprite.frame != 0:
				animated_sprite.frame = 0

func activate():
	emit_signal("activated")
	if door:
		emit_signal("open_door", global_position)
		if animated_sprite is AnimatedSprite:
			if open:
				animated_sprite.play("open", true)
			else:
				animated_sprite.play("open")
			open = !open
	else:
		emit_signal("not_door")

func is_pressable():
	return pressable
