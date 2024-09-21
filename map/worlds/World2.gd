extends World
class_name World2

@export var navigation_region : NavigationRegion2D
var soul_scene = preload("res://characters/souls/Soul.tscn")
var angel_scene = preload("res://characters/angels/Angel.tscn")
var boss_scene = preload("res://characters/boss/Boss.tscn")
 
@export var soul_count : int 
@export var angel_count : int

var souls_array = []
var angels_array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_count = angel_count + soul_count 
	default_path_map = tile_map.get_used_cells(0)
	default_hills_map = tile_map.get_used_cells(2)
	generate_grass(2)
	generate_hills(0)
	set_doors()
	player = await SceneManager.set_player()
	add_child(player)
	player.player_cam.zoom = Vector2(2,2)
	if SceneManager.is_new_level:
		print("it is a new level")
		spawn_player()
		
	set_trees()
	souls_array = await SceneManager.set_enemies(soul_count, soul_scene)
	angels_array = await SceneManager.set_enemies(angel_count, angel_scene)
	enemies = await SceneManager.set_enemies(1, boss_scene)
	spawn_enemies(souls_array)
	spawn_enemies(angels_array)
	print("SOULS: ", souls_array)
	#for en in enemies:
		#print("VICTIM ", en.victim )
	game_ui.set_actor(player)
	navigation_region.bake_navigation_polygon()


func _physics_process(delta):
	is_small_enemies_dead()
	if is_all_enemies_dead():
		exit_door.area.set_deferred("monitoring", true)




func is_small_enemies_dead():
	print("Dead count:", dead_body_count)
	if dead_body_count >= (soul_count + angel_count):
		player.player_cam.enabled = false


func prepare_boss():
	#change camera zoom 
	
	#spawn boss 
	spawn_boss()



func spawn_boss():
	var players_loc = player.get_global_position
	
	
