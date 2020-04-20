extends Control

var ply = false
var credit = false
var ack = false

# Called when the node enters the scene tree for the first time.
func _ready():
	MusicControl.fade()
	$secondary.set_percent_visible(0)
	$title.set_percent_visible(0)
	$priority.set_percent_visible(0)
	$acknowledge.set_percent_visible(0)
	$level1.set_percent_visible(0)
	$level2.set_percent_visible(0)
	$level3.set_percent_visible(0)
	$level4.set_percent_visible(0)
	$names.set_percent_visible(0)
	$back.set_percent_visible(0)

func _on_play_meta_clicked(meta):
	if !ply:
		ply = true
		MusicControl.bloop()
		$play.set_percent_visible(0)
		$credits.set_percent_visible(0)
		$title2.set_percent_visible(0)
		$secondary.set_percent_visible(100)
		$priority.set_percent_visible(100)
		$acknowledge.set_percent_visible(100)
		$title.set_percent_visible(100)

func _on_credits_meta_clicked(meta):
	if !ply:
		ply = true
		credit = true
		MusicControl.bloop()
		$credits.set_percent_visible(0)
		$play.set_percent_visible(0)
		$title2.set_percent_visible(0)
		$names.set_percent_visible(100)
		$back.set_percent_visible(100)

func _on_acknowledge_meta_clicked(meta):
	if ply && !credit:
		ack = true
		MusicControl.bloop()
		get_tree().change_scene("res://Scenes/title/levelselect.tscn")
		$acknowledge.set_percent_visible(0)
		$secondary.set_percent_visible(0)
		$priority.set_percent_visible(0)
		$title2.set_percent_visible(0)
		$title.set_percent_visible(0)
		$level1.set_percent_visible(100)
		$level2.set_percent_visible(100)
		$level3.set_percent_visible(100)
		$level4.set_percent_visible(100)


func _on_back_meta_clicked(meta):
	if credit:
		ply = false
		credit = false
		MusicControl.bloop()
		$names.set_percent_visible(0)
		$back.set_percent_visible(0)
		$title2.set_percent_visible(100)
		$credits.set_percent_visible(100)
		$play.set_percent_visible(100)


func _on_level1_meta_clicked(meta):
	if ack :
		MusicControl.bloop()
		get_tree().change_scene("res://Levels/TestLevel.tscn")


func _on_level2_meta_clicked(meta):
	if ack:
		MusicControl.bloop()


func _on_level3_meta_clicked(meta):
	if ack:
		MusicControl.bloop()


func _on_level4_meta_clicked(meta):
	if ack:
		MusicControl.bloop()
