extends KinematicBody2D
class_name Player

signal is_moving(status)
signal current_pos(pos)

var direction := Vector2(0,0)


export var speed : float = 250
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	emit_signal("current_pos", global_position)
	#print(global_position)
	move_and_slide(direction*speed, Vector2(0,0))

func _input(event):
	if event.is_action_pressed("ui_up"):
		direction += Vector2(0, -1)
	elif event.is_action_released("ui_up"):
		direction += Vector2(0, 1)
	if event.is_action_pressed("ui_down"):
		direction += Vector2(0, 1)
	elif event.is_action_released("ui_down"):
		direction += Vector2(0, -1)
	if event.is_action_pressed("ui_right"):
		direction += Vector2(1, 0)
	elif event.is_action_released("ui_right"):
		direction += Vector2(-1, 0)
	if event.is_action_pressed("ui_left"):
		direction += Vector2(-1, 0)
	elif event.is_action_released("ui_left"):
		direction += Vector2(1, 0)
	emit_signal("is_moving", direction != Vector2(0,0))
	
	if event.is_action_pressed("ui_select"):
		var dist_lowest
		var dist
		var lowest_node = null
		for node in $Area2D.get_overlapping_areas():
			if node is Trigger:
				if lowest_node == null:
					lowest_node = node
				else:
					dist_lowest = lowest_node.get_global_position().distance_to(get_global_position())
					dist = node.get_global_position().distance_to(get_global_position())
					if dist < dist_lowest:
						lowest_node = node
		if(lowest_node != null):
			lowest_node.activate()
