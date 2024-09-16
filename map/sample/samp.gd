extends Node2D


@onready var game_ui = $GameUI

@export var entry_door : ExitDoor
@export var exit_door : ExitDoor
@export var scene_width : int = 50
@export var scene_height : int = 50
var borders = Rect2(1, 1, scene_width, scene_height)

@onready var tile_map = $TileMap
@export var hills_walker : Walker 
@export var grass_walker : Walker 
var hills_map : Array
var grass_map : Array
var enemy0 : Enemy0
var player : Player

var spawning_point : Vector2 = Vector2(25, 25)

func _ready():
	generate_hills()
	generate_paths()

	
		
func _process(delta):
	
	var change = Input.is_action_just_pressed("change_level")
	if change:
		SceneManager.change_scene("res://map/sample/samp.tscn")
		
		
func generate_hills():
	#We initialize the walker with the sizes of the current world
	hills_walker.initialize(spawning_point, borders)
	
	#The main function of the walker that returns an array of all used cells
	hills_map = hills_walker.walk()
	print(hills_map)
	#walker.queue_free()
	#we will make holes on the "hills" layer
	
	tile_map.set_cells_terrain_connect(0,hills_map, 0, 0) 
	

func generate_paths():
	grass_walker.initialize(spawning_point, borders)
	#The main function of the walker that returns an array of all used cells
	var temp_map = grass_walker.walk()
	for tile in temp_map:
		if hills_map.find(tile):
			grass_map.append(tile)
	print(grass_map)
	#walker.queue_free()
	#we will make holes on the "hills" layer
	
	tile_map.set_cells_terrain_connect(1,grass_map, 0, 1) 
	

