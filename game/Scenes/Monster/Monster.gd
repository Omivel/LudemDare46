extends KinematicBody2D
class_name Monster

#how close to its pathfindng goal the monster hase to be to check it off its list
const TOLERENCE := 2.5

export var speed : float = 1

#a first in first out list of positions to move too
var path : PoolVector2Array = []
var direction := Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func _physics_process(delta):
	#On each physics tick we check to see if there is a goal to move to
	#if there is we move to it until we get to it with some fault tolerence
	#Once reached the goal is removed from the que
	if !path.empty():
		if global_position.distance_to(path[0]) <= TOLERENCE:
			path.remove(0)
		else:
			#Move the character to the next target
			direction = path[0]-global_position
			move_and_slide(direction.normalized()*speed, Vector2(0,0))
	

func newPath(newPath : PoolVector2Array):
	path = newPath

func appendPath(newPath: PoolVector2Array):
	path.append_array(newPath)



