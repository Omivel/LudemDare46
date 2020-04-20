extends Area2D
class_name Cage

var full : bool = false

signal traped

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self, "_trap_monster")

func _trap_monster(body):
	if !full:
		if body is Monster:
			body.set_traped(true)
			body.set_physics_process(false)
			body.collisionShape.set_deferred("set_disabled",true)
#			body.vision.set_deferred("set_monitoring",false)
#			body.vision.set_deferred("set_monitorable",false)
#			body.atack.set_deferred("set_monitoring",false)
#			body.atack.set_deferred("set_monitorable",false)
			body.vision.set_monitoring(false)
			body.atack.set_monitoring(false)
			body.set_global_position(global_position)
			full = true
			emit_signal("traped")
