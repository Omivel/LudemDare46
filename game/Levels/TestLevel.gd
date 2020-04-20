extends Node2D
class_name Level_Control

signal door(status)

onready var navTilesPath = load("res://Scenes/NavTileset/NavTileset.tscn")
onready var tileMap = $TestTileMap

var how_many_monsters : int
var how_many_captured : int

var monster_list = []

func _ready():
	$Player.connect("is_moving", self, "is_moving")
	for child in get_children():
		#connect to doors
		if child is Trigger:
			child.connect("open_door", self, "open_door")
			child.connect("not_door", self, "not_door")
		#create and populate navigation mesh for each monster based on tilemap
		elif child is Monster:
			monster_list.append(child)
			how_many_monsters += 1
			child.connect("is_chasing_player", self, "_scary_sounds")
			child.connect("stoped_chasing", self, "_scary_sounds")
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
		elif child is Cage:
			child.connect("traped", self, "_check_win")
		elif child is Alarm:
			child.connect("alarm_start", self, "_alarm")
			child.connect("alarm_stop", self, "_stop_alarm")

func _process(delta):
	for mon in monster_list:
		$music_control.monster(mon.global_position.distance_to($Player.global_position), mon.get_type())

func _alarm(pos):
	for child in get_children():
		if child is Monster:
			child.newGoal(pos, true)

func _stop_alarm():
	for child in get_children():
		if child is Monster:
			child.newPath([])

func _check_win():
	how_many_captured += 1
	if how_many_captured == how_many_monsters:
		get_tree().change_scene("res://Scenes/WinScreen/WinScreen.tscn")

func _input(event):
	if event.is_action_pressed("Left_click"):
		for child in $Monster.get_children():
			if child is Navigation2D:
				$Monster.newPath(child.get_simple_path($Monster.global_position, get_global_mouse_position(), false))

func open_door(cordinates: Vector2):
	cordinates = tileMap.world_to_map(cordinates)
	var to_open : bool = tileMap.get_cellv(cordinates) == 1
	
	if to_open:
		$music_control.open()
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
		$music_control.close()
		tileMap.set_cellv(cordinates, 1) #close door here
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

func is_moving(status):
	$music_control.footsteps(status)

func not_door():
	$music_control.bloop()

func _scary_sounds(type):
	$music_control.toggle_scary_sounds(type)
