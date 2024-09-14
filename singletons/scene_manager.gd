extends Node

var is_new_game : bool

var player: Player
var Player = load("res://characters/player/player.tscn")
var exit_door: ExitDoor
signal level_changed 
signal scene_changed

var level_count : int = 0

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
	print("in change scene")
	var scene = load(scene_name)
	if not scene:
		print("Error loading scene: ", scene_name)
		return
	
	var new_scene = scene.instantiate()
	if not new_scene:
		print("Error instantiating scene: ", scene_name)
		return
		

	var current_scene = get_tree().current_scene
	
	check_player(current_scene, new_scene)
	
	await get_tree().create_timer(0.1).timeout
	get_tree().get_root().add_child(new_scene)
	
	get_tree().current_scene = new_scene
	
	
	scene_changed.emit()
	print("EMITTED")
	
	if current_scene:
		current_scene.queue_free()
	

func check_player(current_scene, next_scene):
	if next_scene.is_in_group("level"):
		player = current_scene.find_child("Player")
		if !player:
			player = Player.instantiate()
		next_scene.add_child(player)



func spawn_player(door_to_spawn):

	var doors = get_tree().current_scene.find_child("Doors")
	
	for door in doors.get_children():
		if door.door_name == door_to_spawn:
			exit_door = door
	print("Door to spawn ", exit_door.door_name)
	if !exit_door:
		print("Error: Cannot find the door of current level.")
		return
	#elif exit_door.connected_door_name == "none":
		#return
	else:
		print("in spawwnn")
		#Check if the door must working or not
		if exit_door.is_enabled:
			#Set the spawn point as marker2d of the door.
			var spawn_point = exit_door.find_child("Marker2D").global_position
		
			player.position = spawn_point
				
			#Disable the door for no further usage
			exit_door.is_enabled = false
			return player
		else:
			#you will need to also assert this, ma'am
			print("Cannot use that door right now")
	


	
