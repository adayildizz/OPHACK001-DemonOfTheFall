extends Node

func save_game():
	
	save_current_scene()

	var save_nodes = get_tree().get_nodes_in_group("Persist")
	
	for node in save_nodes:
		
		add_node_to_json(node)
	
	
		


func load_game():
	print(get_tree().current_scene)
	if not FileAccess.file_exists("user://savegame.txt"):
		return
	
		
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()
		
		
	var save_file = FileAccess.open("user://savegame.txt", FileAccess.READ)
	var last_scene = save_file.get_line()
	SceneManager.change_scene(last_scene)
	
	while not save_file.eof_reached():
		var debug_str = save_file.get_as_text()
		var json_str = save_file.get_line()
		
		
		var json = JSON.new()
		var parse_result = json.parse(json_str)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_str, " at line ", json.get_error_line())
			continue
			
			
		var node_data = json.get_data()
		
		var new_object = load(node_data["filename"]).instantiate()
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

	# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
	save_file.close()
	print(get_tree().current_scene)
	



func add_node_to_json(node):
	
	var arr = []
	var save_file = FileAccess.open("user://savegame.txt", FileAccess.READ)
	arr.append(save_file.get_line())
	while not save_file.eof_reached():
		var json_str = save_file.get_line()
		arr.append(json_str)
		
	save_file.close()
		
		
	save_file = FileAccess.open("user://savegame.txt", FileAccess.WRITE)
		
	
	var node_data = node.call("save")
	var json_str = JSON.stringify(node_data)
	arr.append(json_str)

	for i in arr:
		save_file.store_line(i)
	save_file.close()
	
	
	


func save_current_scene():
	print(get_tree().current_scene)
	var current_scene_path = get_tree().current_scene.get_path()
	
	var save_file = FileAccess.open("user://savegame.txt", FileAccess.WRITE)
	save_file.store_line(current_scene_path)
	save_file.close()
