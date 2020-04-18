extends KinematicBody2D

var direction := Vector2(0,0)

export var speed : float = 250
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
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
	
	if event.is_action_pressed("ui_select"):
		for node in $Area2D.get_overlapping_areas():
			if node is Trigger:
				node.activate()
