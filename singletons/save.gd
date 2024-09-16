extends Node

var game_count : int = 0
var game_number : int
signal game_loaded
var player = Player
var enemies = []
const SAVE_PATH : String = "user://GameSaves/"


func save_game(game_number : int ):
	
	var save_file = FileAccess.open(SAVE_PATH + "savegame{num}.json".format({"num": game_number}), FileAccess.WRITE)
	var current_scene_path = get_tree().current_scene.get_scene_file_path()
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var save_nodes_data = []
	
	for node in save_nodes:
		var node_data = node.call("save")
		print("node data:", node_data)
		save_nodes_data.append(node_data)
	
	var save_object = {"scene": current_scene_path, "save_nodes_data": save_nodes_data, "game_count": game_count}
	save_file.store_line(JSON.stringify(save_object))
	print(JSON.stringify(save_object))
	save_file.close()

func load_game(game_number: int):

	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()
		
	var save_file = FileAccess.open(SAVE_PATH + "savegame{count}.json".format({"count": game_number}), FileAccess.READ)
	if not save_file:
		print("Error opening save file")
		return
		
	var json_string = save_file.get_as_text()
	var json = JSON.new()
	var parse_result = json.parse(json_string)
	
	if parse_result != OK:
		print("Error parsing JSON: ", json.get_error_message())
		save_file.close()
		return
	
	var save_object = json.data
	print("save object:", save_object)
	load_nodes_to_scene(save_object)	
	save_file.close()
	
	
	

func load_nodes_to_scene(save_object):
	#These nodes are only characters of the game. So feel free to use 
	#character components as they are shared among all.
	
	var scene_path = save_object["scene"]
	SceneManager.change_scene(scene_path)
	await get_tree().create_timer(0.2).timeout
	
	for node_data in save_object["save_nodes_data"]:
		print("node data:", node_data)
		var new_object = load(node_data["filename"]).instantiate()
		get_tree().current_scene.add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])
	
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			if i == "current_health":
				new_object.health_component.health_remaining = node_data[i]
			
		if node_data["filename"] == "res://characters/player/player.tscn":
			print("PLAYER INSTANTIATED IN LOAD")
			player = new_object
		if node_data["filename"] == "res://characters/souls/Soul.tscn":
			enemies.append(new_object)
	game_loaded.emit()

func get_games():
	DirAccess.make_dir_recursive_absolute(SAVE_PATH)
	var dir = DirAccess.open(SAVE_PATH)
	
	for file in dir.get_files():
		game_count += 1

	return dir.get_files()


