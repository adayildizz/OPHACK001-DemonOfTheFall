extends World
class_name World0

var borders = Rect2(1, 1, scene_width, scene_height)
var player : Player
var enemies : Array
var default_path_map : Array
var default_hills_map : Array 
var grass_map : Array
var hills_map : Array

var starting_point : Vector2 = Vector2(10, 5)
var level_number = 0
func _ready():
	#check_level_count()
	game_ui.create_new_environment.connect(create_new_environment)
	default_path_map = tile_map.get_used_cells(0)
	default_hills_map = tile_map.get_used_cells(2)
	generate_grass()
	generate_hills()
	set_doors()
	
	
	#Set the player
	player = await SceneManager.set_player()
	add_child(player)
	if SceneManager.is_new_game:
		spawn_player()
	#Set enemies
	enemies = await SceneManager.set_enemies(enemy_count)
	print("ENEMIESSSSS", enemies)
	spawn_enemies(enemies)
	
	game_ui.set_actor(player)
	set_trees()
	

		
func _process(delta):
	var change = Input.is_action_just_pressed("change_level")
	if change: generate_hills()
	
		
		
func generate_grass():
	tile_map.clear_layer(1)
	grass_map = []
	grass_walker.initialize(starting_point, borders)
	grass_map = grass_walker.walk()
	tile_map.set_cells_terrain_connect(1,grass_map, 0, 1) 
	

func generate_hills():
	tile_map.set_cells_terrain_connect(2,default_hills_map, 0, 2) 
	hills_map = []
	hills_walker.initialize(starting_point, borders)
	hills_map = hills_walker.walk()
	print(hills_map)
	tile_map.set_cells_terrain_connect(2,hills_map, 0, -1) 
	
	
func set_trees():
	var available_tiles = grass_map.duplicate()
	
	available_tiles.append_array(tile_map.get_used_cells(2))
	var i = 0
	while i < tree_count:
		var loc = choose_random(available_tiles)
		var tree = trees_scene.instantiate()
		add_child(tree)
		tree.choose_type(1)
		
		print("TREE: ", tree)
		tree.position = loc*TILE_SIZE		
		i += 1
		
	
func choose_random(array):
	return array[randi() % array.size()]
	

func set_doors():
	entry_door.position = hills_map[0]*TILE_SIZE
	exit_door.position = hills_map[-1]*TILE_SIZE
	entry_door.is_enabled = true
	exit_door.is_enabled = true
	
	
	
func create_new_environment():
	check_level_count()
	

func spawn_player():
	
	print("Entry door here ",entry_door.position)
	SceneManager.player.position = entry_door.position
	
	

func delete_enemies():
	pass


func spawn_enemies(enemies):
	for enemy in enemies:
		enemy.set_victim(player)
		add_child(enemy)

func check_level_count():
	if SceneManager.level_count > 2:
		SceneManager.change_scene(next_world_path)
	
	else:
		SceneManager.level_count += 1
		SceneManager.change_scene(this_world_path)
