extends World
class_name World0

var enemy_scene = preload("res://characters/souls/Soul.tscn")



var level_number = 0
var door_locations_here = [Vector2(15, -1),
 	Vector2(16, -1), 
	Vector2(15, -2), 
	Vector2(16, -3), 
	Vector2(15, -3), 
	Vector2(14, -1), 
	Vector2(17, -1),
	Vector2(14, -2),
	Vector2(17, -2),
	Vector2(14, -3),
	Vector2(17, -3),
	Vector2(15, -22),
	Vector2(16, -22),
	Vector2(14, -22),
	Vector2(17, -22),
	Vector2(14, -23),
	Vector2(17, -23),
	Vector2(15, -23),
	Vector2(16, -23),
	Vector2(14, -24),
	Vector2(17, -24),
	Vector2(15, -24),
	Vector2(16, -24),]

func _ready():
	game_ui.create_new_environment.connect(create_new_environment)
	door_locations = door_locations_here
	default_path_map = tile_map.get_used_cells(0)
	default_hills_map = tile_map.get_used_cells(2)
	generate_grass(1)
	generate_hills(2)
	set_doors()
	
	
	#Set the player
	player = await SceneManager.set_player()
	add_child(player)
	player.player_cam.zoom =Vector2(2,2)
	
	if SceneManager.is_new_level:
		spawn_player()
	
	#Set enemies
	enemies = await SceneManager.set_enemies(enemy_count, enemy_scene)
	
	print("ENEMIESSSSS", enemies)
	spawn_enemies(enemies)
	
	game_ui.set_actor(player)
	set_trees()
	
	
func _physics_process(delta):
	pass
		
		

	

	


