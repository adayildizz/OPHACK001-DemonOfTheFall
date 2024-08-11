extends Node2D
class_name World

@export var scene_width : int = 20
@export var scene_height : int = 15

var borders = Rect2(1, 1, scene_width, scene_height)

@onready var tile_map = $TileMap
@export var walker : Walker 

var map : Array
@export var door_name : String 


func _ready():
	SceneManager.spawn_player(door_name)
	generate_world()

func _process(delta):
	
	var change = Input.is_action_just_pressed("change_level")
	if change:
		get_tree().reload_current_scene()
		
		
func generate_world():
	#We initialize the walker with the sizes of the current world
	walker.initialize(Vector2(10, 10), borders)
	
	#The main function of the walker that returns an array of all used cells
	map = walker.walk()
	
	#walker.queue_free()
	
	tile_map.set_cells_terrain_connect(0,map, 0, 0) 

