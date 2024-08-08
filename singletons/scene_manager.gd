extends Node

var Player = load("res://characters/player/player.tscn")

var exit_door: ExitDoor
signal level_changed 


func _process(delta):
	if Input.is_action_just_pressed("Quit"):
		quit_game()

func start_game():
	Save.load_game()
	
	
func quit_game():
	Save.save_game()
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
		
	

	

func go_to_next_level(next_level_path):
	print("in next level")
	change_scene(next_level_path)
	spawn_player();

func spawn_player():
	exit_door = get_tree().current_scene.find_child("ExitDoor")
	if !exit_door:
		print("Error: Cannot find the door of current level.")
		return
	else:
		print("door found")
		var spawn_point = exit_door.find_child("Marker2D").global_position
		print(spawn_point)
		var player = Player.instantiate()
		get_tree().current_scene.add_child(player)
		print(player)
		player.position = spawn_point
	
	

