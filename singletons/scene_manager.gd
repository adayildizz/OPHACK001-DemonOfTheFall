extends Node

var is_new_level : bool
var is_new_game : bool

var player_scene = preload("res://characters/player/player.tscn")
var enemy_scene = preload("res://characters/souls/Soul.tscn")
var exit_door: ExitDoor

signal scene_changed
signal player_set

var player : Player

var level_count : int = 0

func _ready():
	scene_changed.connect(set_player)

func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		if is_new_game:
			save_and_quit_game(Save.game_count)
		else:
			save_and_quit_game(Save.game_number)

func start_saved_game(game_number : int):
	Save.load_game(game_number)
	
func save_and_quit_game(game_number : int):
	Save.save_game(game_number)
	get_tree().quit()
	
func quit_without_saving_game():
	get_tree().quit()
	
func change_scene(scene_name: String):
	print("Scene is changing... New scene: ", scene_name)
	var scene = load(scene_name)
	if not scene:
		print("Error loading scene: ", scene_name)
		return
	
	var new_scene = scene.instantiate()
	if not new_scene:
		print("Error instantiating scene: ", scene_name)
		return
		

	var current_scene = get_tree().current_scene
	
	
	await get_tree().create_timer(0.1).timeout
		
	get_tree().get_root().add_child(new_scene)
	
	get_tree().current_scene = new_scene
	
	
	#new_scene.change_world.connect(on_change_world)
	
	scene_changed.emit()
	print("SCENE CHANGED SIGNAL EMITTED")
	
	if current_scene:
		current_scene.queue_free()
	

#func spawn_player(door_to_spawn):
	#var doors = get_tree().current_scene.find_child("Doors")
	#print("Spawning player into current scene: ",get_tree().current_scene)
	#for door in doors.get_children():
		#if door.door_name == door_to_spawn:
			#exit_door = door
	#
	#if !exit_door:
		#print("Error: Cannot find the door of current level.")
		#return
	##elif exit_door.connected_door_name == "none":
		##return
	#else:
		#print("Door to spawn found: ", exit_door.door_name)
		##Check if the door must working or not
		#
		#if exit_door.is_enabled:
			##Set the spawn point as marker2d of the door.
			#var spawn_point = exit_door.find_child("Marker2D").global_position
			##var player = player_scene.instantiate()
			#
			#get_tree().current_scene.add_child(player)
			#player.position = spawn_point
				#
			##Disable the door for no further usage
			#exit_door.is_enabled = false
			#return player
		#else:
			##you will need to also assert this, ma'am
			#print("Cannot use that door right now")
	#
#


func set_player():
	print("in set ")
	if is_new_game:
		player = player_scene.instantiate()	
		player.health_component.initialize_health()
	else:
		await Save.game_loaded
		player = Save.player
	player_set.emit()
	
	return player
	
func set_enemies(enemy_count):
	var enemies = []
	if SceneManager.is_new_game:
		print("new enemies is being sett.")
		var i = 0
		while i < enemy_count:
			var enemy = enemy_scene.instantiate()
			enemies.append(enemy)
			
			#enemy.position = choose_random(default_path_map)*TILE_SIZE
			print("Enemy: ", enemy, "Position: ", enemy.position)
			i += 1
			
	else:
		enemies = await Save.enemies
		print("enemies :", enemies)
		for enemy in enemies:
			if player:
				enemy.set_victim(player)
		print(enemies)
	return enemies



	
