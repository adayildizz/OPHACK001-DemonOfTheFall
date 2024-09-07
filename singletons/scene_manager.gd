extends Node

var Player = load("res://characters/player/player.tscn")

var exit_door: ExitDoor
signal level_changed 


func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		save_and_quit_game()

func start_game():
	Save.load_game()
	
	
func save_and_quit_game():
	Save.save_game()
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
	get_tree().get_root().add_child(new_scene)
	get_tree().current_scene = new_scene

	if current_scene:
		current_scene.queue_free()
		
		

func go_to_next_level(next_level_path, connected_door_name):
	change_scene(next_level_path)
	spawn_player(connected_door_name);

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
		#Check if the door must working or not
		if exit_door.is_enabled:
			#Set the spawn point as marker2d of the door.
			var spawn_point = exit_door.find_child("Marker2D").global_position
			#Instantiate the player
			var player = Player.instantiate()
			get_tree().current_scene.add_child(player)
			player.position = spawn_point
			if exit_door.door_name != "_level0":
				player.add_player_cam()
			#Disable the door for no further usage
			exit_door.is_enabled = false
			return player
		else:
			#you will need to also assert this, ma'am
			print("Cannot use that door right now")
	


