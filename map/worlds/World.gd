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
var scene_width : int = 28
var scene_height : int = 18

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

func choose_random(array):
	return array[randi() % array.size()]



func create_new_environment():
	check_level_count()
	
	
func check_level_count():
	print("checking level count:", SceneManager.level_count)
	SceneManager.level_count += 1
	if SceneManager.level_count > 0:
		SceneManager.change_scene(next_world_path)
	
	else:
		SceneManager.change_scene(this_world_path)




func set_doors():
	entry_door.area.set_deferred("monitoring", false)
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
		
		return true
	return false


func spawn_enemies(enemies):
	print("in spawn enemies")
	for enemy in enemies:
		add_child(enemy)
		enemy.set_victim(player)
		enemy.health_component.body_died.connect(on_enemy_dies)
		if SceneManager.is_new_game:
			enemy.position = hills_map[randi() % hills_map.size()]*TILE_SIZE
		

func on_enemy_dies():
	dead_body_count += 1
	if is_all_enemies_dead():
		exit_door.area.set_deferred("monitoring", true)

func set_trees():
	var corridor = get_corridor_tiles()
	var available_tiles = grass_map.duplicate()
	
	for tile in available_tiles:
		if corridor.has(tile):
			available_tiles.erase(tile)

	var i = 0
	while i < tree_count and available_tiles.size() > 0:
		var loc = choose_random(available_tiles)
		
		# Create and position the tree
		var tree = trees_scene.instantiate()
		add_child(tree)
		tree.choose_type(theme)
		tree.position = loc * TILE_SIZE
		
		# Collect neighbors to erase
		var tiles_to_erase = []
		for k in range(loc.x - 2, loc.x + 3):
			for j in range(loc.y - 3, loc.y + 4):
				var neighbor = Vector2(k, j)
				if available_tiles.has(neighbor):
					tiles_to_erase.append(neighbor)
		
		# Erase neighbors from available tiles
		for tile in tiles_to_erase:
			available_tiles.erase(tile)
			print("ERASED: ", tile)
		
		i += 1
		

func get_corridor_tiles():
	var corridor_tiles = []
	for i in range(14,18):
		for j in range(0, 21):
			corridor_tiles.append(Vector2(i,j))
	return corridor_tiles


