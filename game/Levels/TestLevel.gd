extends Node2D

onready var navTilesPath = load("res://Scenes/NavTileset/NavTileset.tscn")
onready var tileMap = $TestTileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	#create and populate navigation mesh for each monster based on tilemap
	for child in get_children():
		if child is Monster:
			var navTiles = navTilesPath.instance()
			for tile in tileMap.get_used_cells():
				navTiles.set_cellv(tile, 0)
			var nav = Navigation2D.new()
			nav.add_child(navTiles)
			$Monster.add_child(nav)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("Left_click"):
		for child in $Monster.get_children():
			if child is Navigation2D:
				$Monster.newPath(child.get_simple_path($Monster.global_position, get_global_mouse_position(), false))
