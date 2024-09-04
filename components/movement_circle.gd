extends Node2D
class_name MovementCircle

@onready var north = $North
@onready var north_east = $NorthEast
@onready var east = $East
@onready var south_east = $SouthEast
@onready var south = $South
@onready var south_west = $SouthWest
@onready var west = $West
@onready var north_west = $NorthWest
@onready var ray = $RayCast2D

var avoidance_direction : Vector2
@export var actor : CharacterBody2D

@export var speed : float 
@export var time : int 

func _ready():
	
	var raylength = time*speed
	north.target_position = Vector2(0, -1)*raylength
	north_east.target_position = Vector2(1, -1).normalized()*raylength
	east.target_position = Vector2(1 ,0)*raylength
	south_east.target_position = Vector2(1, 1).normalized()*raylength
	south.target_position = Vector2(0, 1)*raylength
	south_west.target_position = Vector2(-1, 1).normalized()*raylength
	west.target_position = Vector2(-1, 0)*raylength
	north_west.target_position = Vector2(-1, -1).normalized()*raylength
	
func _physics_process(delta):
	pass

#to be able to choose a random direction without colliding with obstacles
func choose_random_direction():
	var random_dir = Vector2.ZERO
	var dirs = self.get_children()
	var available_dirs : Array
	for dir in dirs:
		if !dir.is_colliding():
			available_dirs.append(dir)
	if available_dirs.size() != 0:
		random_dir = available_dirs[randi()%available_dirs.size()].target_position.normalized()
		
	else:
	
		random_dir = Vector2.ZERO
		
	return random_dir
	

