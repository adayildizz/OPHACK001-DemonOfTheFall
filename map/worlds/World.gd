extends Node2D
class_name World

const TILE_SIZE = 32

signal change_world


var player : Player
var enemies : Array


@export var this_world_path : String
@export var next_world_path : String
@export var enemy_count : int 
@export var tree_count : int
@export var scene_width : int = 30
@export var scene_height : int = 22

@export var game_ui : GameUI
@export var entry_door : ExitDoor
@export var exit_door : ExitDoor
@export var tile_map : TileMap
@export var grass_walker : Walker 
@export var hills_walker : Walker

@export var theme : int 

var default_path_map : Array
var default_hills_map : Array 
var grass_map : Array
var hills_map : Array
var borders = Rect2(1, 1, scene_width, scene_height)
var starting_point : Vector2 = Vector2(10, 5)

var trees_scene = preload("res://objects/trees/Tree0.tscn")

var dead_body_count = 0

var door_locations : Array

func choose_random(array):
	return array[randi() % array.size()]



func create_new_environment():
	check_level_count()
	
	
func check_level_count():
	SceneManager.level_count += 1
	if SceneManager.level_count > 0:
		SceneManager.change_scene(next_world_path)
	
	else:
		SceneManager.change_scene(this_world_path)




func set_doors():
	exit_door.area.set_deferred("monitoring", false)
	

func spawn_player():
	SceneManager.player.position = entry_door.position

func generate_grass(grass_layer: int):
	tile_map.clear_layer(grass_layer)
	grass_map = []
	grass_walker.initialize(starting_point, borders)
	grass_map = grass_walker.walk()
	tile_map.set_cells_terrain_connect(grass_layer,grass_map, 0, 1) 
	

func generate_hills(hills_layer: int):
	tile_map.set_cells_terrain_connect(hills_layer,default_hills_map, 0, 2) 
	hills_map = []
	hills_walker.initialize(starting_point, borders)
	hills_map = hills_walker.walk()
	
	tile_map.set_cells_terrain_connect(hills_layer,hills_map, 0, -1) 
	
	
func is_all_enemies_dead():

	if dead_body_count >= enemy_count:
		print("ALL DEAD")
		return true
	return false


func spawn_enemies(enemies):
	print("in spawn enemies")
	for enemy in enemies:
		enemy.position = hills_map[randi() % hills_map.size()]*TILE_SIZE
		enemy.set_victim(player)
		add_child(enemy)
		enemy.health_component.body_died.connect(on_enemy_dies)
		

func on_enemy_dies():
	dead_body_count += 1

func set_trees():
	var available_tiles = grass_map.duplicate()
	for tile in door_locations:
		available_tiles.erase(tile)
		
	available_tiles.append_array(tile_map.get_used_cells(2))
	var i = 0
	while i < tree_count:
		var loc = choose_random(available_tiles)
		var tree = trees_scene.instantiate()
		add_child(tree)
		tree.choose_type(theme)
		tree.position = loc*TILE_SIZE	
		var surroundings = tile_map.get_surrounding_cells(loc)
		for tile in surroundings:
			available_tiles.erase(tile)
		available_tiles.erase(loc)
			
		i += 1
		
