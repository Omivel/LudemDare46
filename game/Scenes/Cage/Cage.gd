extends Area2D
class_name Cage

onready var cage = $cage
onready var anima = $AnimatedSprite

#which type of monster this goes to, -1 means it acepts all monsters
export var type : int = -1

var full : bool = false

signal traped

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("body_entered", self, "_trap_monster")
	cage.hide()
	match type:
		-1:
			cage.play("default")
			anima.play("default")
		0:
			cage.play("Monster0")
			anima.play("Monster0")
		1:
			cage.play("Monster1")
			anima.play("Monster1")

func _trap_monster(body):
	if !full:
		if body is Monster:
			if type == -1 or body.get_type() == type:
				cage.show()
				body.set_traped(true)
				body.set_physics_process(false)
				body.collisionShape.set_deferred("set_disabled",true)
				body.vision.set_monitoring(false)
				body.atack.set_monitoring(false)
				body.set_global_position(global_position)
				full = true
				emit_signal("traped")
