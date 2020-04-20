extends KinematicBody2D
class_name Monster

onready var vision = $Vision
onready var chaseTimer = $ChaseTimer
onready var chaseUpdate = $ChaseUpdateTimer
onready var atack = $Atack
signal failstate()

#how close to its pathfindng goal the monster hase to be to check it off its list
const TOLERENCE := 11

export var running_speed : float = 200
export var walking_speed : float = 75

var playerpos

#left uninitialized to be initialized with an outside call
var pathfinding : Navigation2D
#another entity that this node will track down
var target = null
var speed = walking_speed
#a first in first out list of positions to move too
var path : PoolVector2Array = []
var direction := Vector2()

var placesToGo = []


# Called when the node enters the scene tree for the first time.
func _ready():
	vision.connect("body_entered", self, "_new_target")
	chaseTimer.connect("timeout", self, "_end_chase")
	chaseUpdate.connect("timeout", self, "_update_target_path")
	atack.connect("body_entered", self, "_catch")
	pass # Replace with function body.

# warning-ignore:unused_argument
func _physics_process(delta):
	if playerpos != null:
		$monstermusic.set_volume_db( -(global_position.distance_to(playerpos) / 20.0) + 6)
	#On each physics tick we check to see if there is a goal to move to
	#if there is we move to it until we get to it with some fault tolerence
	#Once reached the goal is removed from the que
	if !path.empty():
		if global_position.distance_to(path[0]) <= TOLERENCE:
			path.remove(0)
		else:
			#the character to the next target
			direction = path[0]-global_position
			move_and_slide(direction.normalized()*speed, Vector2(0,0))
	else:
		placesToGo.shuffle()
		newPath(pathfinding.get_simple_path(global_position, placesToGo[0], false))

func _catch(caught):
	if !$failsound.is_playing() && str(caught) == "[KinematicBody2D:1283]": 
		print("I caught ", caught)
		$failsound.play()
		$monstermusic.stop()
		emit_signal("failstate")

func newPath(newPath : PoolVector2Array):
	path = newPath

func appendPath(newPath: PoolVector2Array):
	path.append_array(newPath)

func _on_KinematicBody2D_current_pos(pos):
	playerpos = pos

func _new_target(new_target):
	if new_target is Player:
		speed = running_speed
		target = new_target
		newPath(pathfinding.get_simple_path(global_position, target.get_global_position(), false))
		chaseTimer.start()
		chaseUpdate.start()

func _update_target_path():
	newPath(pathfinding.get_simple_path(global_position, target.get_global_position(), false))

func _end_chase():
	chaseUpdate.stop()
	target = null
	path = []
	speed = walking_speed

func map_updated():
	placesToGo.clear()
	for child in pathfinding.get_children():
		if child is TileMap:
			for pos in child.get_used_cells():
				placesToGo.append(child.map_to_world(pos))
	if !path.empty():
		newPath(pathfinding.get_simple_path(global_position, path[path.size()-1], false))

#called after pathfinding node is initialized from outside
func initialize_pathfinding():
	for child in get_children():
		if child is Navigation2D:
			pathfinding = child
			return

