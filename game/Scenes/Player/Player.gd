extends KinematicBody2D
class_name Player

signal is_moving(status)

onready var sprite = $AnimatedSprite

var direction := Vector2(0,0)


export var speed : float = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	move_and_slide(direction*speed, Vector2(0,0))

func _input(event):
	if event.is_action_pressed("ui_up"):
		direction += Vector2(0, -1)
		sprite.playing = true
		sprite.play("up")
	elif event.is_action_released("ui_up"):
		direction += Vector2(0, 1)
	if event.is_action_pressed("ui_down"):
		direction += Vector2(0, 1)
		sprite.playing = true
		sprite.play("down")
	elif event.is_action_released("ui_down"):
		direction += Vector2(0, -1)
		sprite.playing = true
	if event.is_action_pressed("ui_right"):
		direction += Vector2(1, 0)
		sprite.playing = true
		sprite.play("right")
	elif event.is_action_released("ui_right"):
		direction += Vector2(-1, 0)
	if event.is_action_pressed("ui_left"):
		direction += Vector2(-1, 0)
		sprite.playing = true
		sprite.play("left")
	elif event.is_action_released("ui_left"):
		direction += Vector2(1, 0)
	
	if direction == Vector2(0,0):
		sprite.playing = false
	#todo make this more better
	emit_signal("is_moving", direction != Vector2(0,0))
	
	if event.is_action_pressed("ui_select"):
		var dist_lowest
		var dist
		var lowest_node = null
		for node in $Area2D.get_overlapping_areas():
			if node is Trigger:
				if node.is_pressable():
					if lowest_node == null:
						lowest_node = node
					else:
						dist_lowest = lowest_node.get_global_position().distance_to(get_global_position())
						dist = node.get_global_position().distance_to(get_global_position())
						if dist < dist_lowest:
							lowest_node = node
		if(lowest_node != null):
			lowest_node.activate()
