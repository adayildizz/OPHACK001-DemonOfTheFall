extends World
class_name World0

var enemy_scene = preload("res://characters/souls/Soul.tscn")

var level_number = 0


func _ready():
	game_ui.create_new_environment.connect(create_new_environment)
	default_path_map = tile_map.get_used_cells(1)
	default_hills_map = tile_map.get_used_cells(0)
	generate_grass(2)
	generate_hills(0)
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
		
		

	

	


