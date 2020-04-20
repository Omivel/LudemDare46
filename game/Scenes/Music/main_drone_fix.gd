extends AudioStreamPlayer

var vcf_main = AudioServer.get_bus_effect(1,0)
var i = 200


func _ready():
	print("ready")
	$Timer.connect("timeout", self, "fade_in")
	$Timer.start(0.003)
	set_volume_db(-40)
	vcf_main.set_cutoff(0)
	vcf_main.set_resonance(0.97)
	if !is_playing():
		play()

func fade_in():
	if (i < 500):
		vcf_main.set_cutoff(pow(2, i / 34.95))
		if (-40 + ( i / 6.25) <= -4):
			set_volume_db(-40 + (i / 6.25))
	else:
		$Timer.queue_free()
	i += 1
