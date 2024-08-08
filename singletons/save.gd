extends Node

func save_game():
	
	
	var save_file = FileAccess.open("user://savegame.json", FileAccess.WRITE)
	var current_scene_path = get_tree().current_scene.absolute_path
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	var save_nodes_data = []
	
	for node in save_nodes:
		var node_data = node.call("save")
		save_nodes_data.append(node_data)
	
	var save_object = {"scene": current_scene_path, "save_nodes_data": save_nodes_data}
	save_file.store_line(JSON.stringify(save_object))
	print(JSON.stringify(save_object))
	save_file.close()

func load_game():

	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		i.queue_free()
		
	var save_file = FileAccess.open("user://savegame.json", FileAccess.READ)
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
	var scene_path = save_object["scene"]
	SceneManager.change_scene(scene_path)
	load_nodes_to_scene.call_deferred(save_object)	
	save_file.close()
	
	

func load_nodes_to_scene(save_object):
	#below code is executed before the scene is actually changed. 
	for node_data in save_object["save_nodes_data"]:
		print("node data:", node_data)
		var new_object = load(node_data["filename"]).instantiate()
		print(get_tree().current_scene)
		get_node(node_data["parent"]).add_child(new_object)
		new_object.position = Vector2(node_data["pos_x"], node_data["pos_y"])

	# Now we set the remaining variables.
		for i in node_data.keys():
			if i == "filename" or i == "parent" or i == "pos_x" or i == "pos_y":
				continue
			new_object.set(i, node_data[i])
