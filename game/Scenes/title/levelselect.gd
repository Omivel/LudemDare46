extends Control

var ply = false
var credit = false
var ack = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if !MusicControl.is_playing_main():
		MusicControl.fade()
	$acknowledge.set_percent_visible(0)
	$secondary.set_percent_visible(0)
	$priority.set_percent_visible(0)
	$title2.set_percent_visible(0)
	$title.set_percent_visible(0)
	$level1.set_percent_visible(100)
	$level2.set_percent_visible(100)
	$level3.set_percent_visible(100)
	$level4.set_percent_visible(100)



func _on_level1_meta_clicked(meta):
	MusicControl.bloop()
	get_tree().change_scene("res://Levels/TestLevel.tscn")


func _on_level2_meta_clicked(meta):
	MusicControl.bloop()
	#get_tree().change_scene("res://Levels/TestLevel.tscn")

func _on_level3_meta_clicked(meta):
	MusicControl.bloop()
	#get_tree().change_scene("res://Levels/TestLevel.tscn")

func _on_level4_meta_clicked(meta):
	MusicControl.bloop()
	#get_tree().change_scene("res://Levels/TestLevel.tscn")


func _on_level5_meta_clicked(meta):
	MusicControl.bloop()
	#get_tree().change_scene("res://Levels/TestLevel.tscn")

func _on_level6_meta_clicked(meta):
	MusicControl.bloop()
	#get_tree().change_scene("res://Levels/TestLevel.tscn")

func _on_level7_meta_clicked(meta):
	MusicControl.bloop()
	#get_tree().change_scene("res://Levels/TestLevel.tscn")

func _on_level8_meta_clicked(meta):
	MusicControl.bloop()
	#get_tree().change_scene("res://Levels/TestLevel.tscn")
