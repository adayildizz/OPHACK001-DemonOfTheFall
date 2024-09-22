extends World
class_name World1

var enemy_scene = preload("res://characters/angels/Angel.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	game_ui.create_new_environment.connect(create_new_environment)
	default_path_map = tile_map.get_used_cells(0)
	default_hills_map = tile_map.get_used_cells(2)
	generate_grass(2)
	generate_hills(0)
	set_doors()
	print("World ONE")
	player = await SceneManager.set_player()
	add_child(player)
	player.player_cam.zoom = Vector2(1.5,1.5)

	
	if SceneManager.is_new_level:
		spawn_player()
		
	set_trees()
	enemies = await SceneManager.set_enemies(enemy_count, enemy_scene)
	spawn_enemies(enemies)
	game_ui.set_actor(player)


func _physics_process(delta):
	pass
		
