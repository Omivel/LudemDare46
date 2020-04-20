extends Area2D

var full : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self, "_trap_monster")

func _trap_monster(body):
	if body is Monster and !full:
		body.set_physics_process(false)
		body.vision.set_monitoring(false)
		body.atack.set_monitoring(false)
		body.set_global_position(global_position)
		full = true
