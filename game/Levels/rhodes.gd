extends AudioStreamPlayer


func _ready():
	set_volume_db(0)
	play()
	#vca.set_volume_db() #TODO: set the volume equal to distance between player and obj

