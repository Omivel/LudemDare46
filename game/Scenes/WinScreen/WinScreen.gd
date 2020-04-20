extends Control

func _ready():
	MusicControl.winstate()
	
func _process(delta):
	MusicControl.main_stop()


func _on_return_meta_clicked(meta):
	MusicControl.bloop()
	get_tree().change_scene("res://Scenes/title/levelselect.tscn")
