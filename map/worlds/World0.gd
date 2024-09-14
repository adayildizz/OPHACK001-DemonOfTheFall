extends Node2D
class_name World

@onready var game_ui = $GameUI

@export var entry_door : ExitDoor
@export var exit_door : ExitDoor
@export var scene_width : int = 50
@export var scene_height : int = 50
var borders = Rect2(1, 1, scene_width, scene_height)

@onready var tile_map = $TileMap
@export var walker : Walker 

var map : Array
var enemy0 : Enemy0
var player : Player

var spawning_point : Vector2 = Vector2(25, 25)

func _ready():
	SceneManager.scene_changed.connect(_on_scene_loaded)
	
	
func _on_scene_loaded():
	generate_hills()
	entry_door.position = map[0]*32
	exit_door.position = map[-1]*32
	entry_door.is_enabled = true
	exit_door.is_enabled = true
	print("AAAAAAAAAA")
	if SceneManager.is_new_game:
		SceneManager.spawn_player(entry_door.door_name)
		SceneManager.is_new_game = false
	
	game_ui.set_actor()
		
		
func _process(delta):
	
	var change = Input.is_action_just_pressed("change_level")
	if change:
		get_tree().reload_current_scene()
		
		
func generate_hills():
	#We initialize the walker with the sizes of the current world
	walker.initialize(spawning_point, borders)
	
	#The main function of the walker that returns an array of all used cells
	map = walker.walk()
	
	#walker.queue_free()
	#we will make holes on the "hills" layer
	
	tile_map.set_cells_terrain_connect(1,map, 0, 0) 
	

func generate_paths():
	walker.initialize(Vector2(19, 11), borders)
	#handle the map logic

