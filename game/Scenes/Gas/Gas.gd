extends Area2D
class_name Gas

onready var down = $DetectDown
onready var up = $DetectRight
onready var left = $DetectLeft
onready var right = $DetectRigh
onready var decay = $DecayTimer

func _ready():
	decay.connect("timeout", self, "_vanish")

#mabe switch this to physics process
func _process(delta):
	pass

func _vanish():
	queue_free()
