extends KinematicBody2D
class_name Monster

onready var vision = $Vision
onready var chaseTimer = $ChaseTimer
onready var chaseUpdate = $ChaseUpdateTimer
onready var atack = $Atack
onready var collisionShape = $CollisionShape2D
onready var animation = $AnimatedSprite

signal is_chasing_player(type)
signal stoped_chasing(type)
#how close to its pathfindng goal the monster hase to be to check it off its list
const TOLERENCE := 11

export var running_speed : float = 75
export var walking_speed : float = 35
#0 is teeth, 1 is leggy
export var monster_type : int = 0

#left uninitialized to be initialized with an outside call
var pathfinding : Navigation2D
#another entity that this node will track down
var target = null
var speed = walking_speed
#a first in first out list of positions to move too
var path : PoolVector2Array = []
var direction := Vector2()
var traped : bool = false
var placesToGo = []
var ignore_targets : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Monster")
	vision.connect("body_entered", self, "_new_target")
	chaseTimer.connect("timeout", self, "_end_chase")
	chaseUpdate.connect("timeout", self, "_update_target_path")
	atack.connect("body_entered", self, "_catch")
	if monster_type == 0:
		animation.play("Monster0")
	elif monster_type == 1:
		animation.play("Monster1")

# warning-ignore:unused_argument
func _physics_process(delta):
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
		ignore_targets = false
		placesToGo.shuffle()
		newPath(pathfinding.get_simple_path(global_position, placesToGo[0], false))

func _catch(caught):
	if caught is Player:
		get_tree().change_scene("res://Scenes/LoseScreen/LoseScreen.tscn")
	if caught.is_in_group("Monster"):
		if caught == self or caught.is_traped():
			return
		else:
			get_tree().change_scene("res://Scenes/LoseScreen/LoseScreen.tscn")

func newGoal(pos : Vector2, top_priority : bool = false):
	if top_priority:
		speed = running_speed
		ignore_targets = true
	newPath(pathfinding.get_simple_path(global_position, pos, false))

func newPath(newPath : PoolVector2Array):
	path = newPath

func appendPath(newPath: PoolVector2Array):
	path.append_array(newPath)


func _new_target(new_target):
	if !ignore_targets:
		if new_target is Player:
			emit_signal("is_chasing_player", monster_type)
			speed = running_speed
			target = new_target
			newPath(pathfinding.get_simple_path(global_position, target.get_global_position(), false))
			chaseTimer.start()
			chaseUpdate.start()
		elif new_target.is_in_group("Monster"):
			if new_target == self:
				return
			if new_target.is_traped():
				return
			speed = running_speed
			target = new_target
			newPath(pathfinding.get_simple_path(global_position, target.get_global_position(), false))
			chaseTimer.start()
			chaseUpdate.start()

func get_type():
	return monster_type

func set_traped(new_traped):
	if target != null:
		emit_signal("stoped_chasing", monster_type)
	traped = new_traped

func is_traped():
	return traped

func _update_target_path():
	newPath(pathfinding.get_simple_path(global_position, target.get_global_position(), false))

func _end_chase():
	emit_signal("stoped_chasing", monster_type)
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

