extends Node2D
class_name Alarm

onready var dur_timer = $Duration
onready var anima = $AnimatedSprite

export var duration : float = 20

signal alarm_start(pos)
signal alarm_stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	dur_timer.connect("timeout", self, "stop")
	dur_timer.wait_time = duration
	anima.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_off():
	dur_timer.start()
	emit_signal("alarm_start", global_position)
	anima.play("going")

func stop():
	emit_signal("alarm_stop")
	anima.play("default")
