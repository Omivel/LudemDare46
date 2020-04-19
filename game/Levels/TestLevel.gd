extends Node2D

onready var navTilesPath = load("res://Scenes/NavTileset/NavTileset.tscn")
onready var tileMap = $TestTileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for child in get_children():
		#connect to doors
		if child is Trigger:
			child.connect("open_door", self, "open_door")
		#create and populate navigation mesh for each monster based on tilemap
		elif child is Monster:
			var navTiles = navTilesPath.instance()
			for tile in tileMap.get_used_cells():
				match tileMap.get_cellv(tile):
					0:
						navTiles.set_cellv(tile, 0)
					1:
						pass
					2:
						navTiles.set_cellv(tile, 0)
				
			var nav = Navigation2D.new()
			nav.add_child(navTiles)
			child.add_child(nav)
			child.initialize_pathfinding()
			child.map_updated()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	if event.is_action_pressed("Left_click"):
		for child in $Monster.get_children():
			if child is Navigation2D:
				$Monster.newPath(child.get_simple_path($Monster.global_position, get_global_mouse_position(), false))

func open_door(cordinates: Vector2):
	cordinates = tileMap.world_to_map(cordinates)
	var to_open : bool = tileMap.get_cellv(cordinates) == 1
	
	if to_open:
		tileMap.set_cellv(cordinates, 2)
		tileMap.update_dirty_quadrants()
		for child in get_children():
			if child is Monster:
				for child2 in child.get_children():
					if child2 is Navigation2D:
						for child3 in child2.get_children():
							if child3 is TileMap:
								child3.set_cellv(cordinates, 0)
								child3.update_dirty_quadrants()
								child.map_updated()
	else:
		tileMap.set_cellv(cordinates, 1)
		tileMap.update_dirty_quadrants()
		for child in get_children():
			if child is Monster:
				for child2 in child.get_children():
					if child2 is Navigation2D:
						for child3 in child2.get_children():
							if child3 is TileMap:
								child3.set_cellv(cordinates, -1)
								child3.update_dirty_quadrants()
								child.map_updated()
