extends World
class_name World2

@export var navigation_region : NavigationRegion2D
var enemy_scene = preload("res://characters/boss/Boss.tscn")
@export var angel_count : int 
@export var soul_count : int 

# Called when the node enters the scene tree for the first time.
func _ready():
	default_path_map = tile_map.get_used_cells(0)
	default_hills_map = tile_map.get_used_cells(2)
	generate_grass(2)
	generate_hills(0)
	set_doors()
	player = await SceneManager.set_player()
	add_child(player)
	player.player_cam.zoom = Vector2(0.7,0.7)

	
	if SceneManager.is_new_level:
		print("it is a new level")
		spawn_player()
		
	set_trees()
	enemies = await SceneManager.set_enemies(enemy_count, enemy_scene)
	spawn_enemies(enemies)
	for en in enemies:
		print("VICTIM ", en.victim )
	game_ui.set_actor(player)
	navigation_region.bake_navigation_polygon()


func _physics_process(delta):
	if is_all_enemies_dead():
		exit_door.area.set_deferred("monitoring", true)


func spawn_enemies(enemies):
	print("in spawn enemies")
	for enemy in enemies:
		enemy.position = hills_map[randi() % hills_map.size()]*TILE_SIZE
		enemy.set_victim(player)
		add_child(enemy)
		enemy.health_component.body_died.connect(on_enemy_dies)
		

	
	
