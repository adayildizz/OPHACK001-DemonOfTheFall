extends Node

var current_scene : Node2D
var exit_door: ExitDoor

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_scene:
		exit_door = get_exit_door(current_scene)


func get_exit_door(scene: Node2D):
	if scene:
		return scene.find_child("ExitDoor")
		
		
func start_game():
	Save.load_game()
	
	
func quit_game():
	Save.save_game()
	get_tree().quit()
	
func change_scene(scene_name: String):
	var scene = load(scene_name)
	if not scene:
		print("Error loading scene: ", scene_name)
		return
	
	var new_scene = scene.instance()
	if not new_scene:
		print("Error instantiating scene: ", scene_name)
		return

	var current_scene = get_tree().current_scene
	get_tree().get_root().add_child(new_scene)
	get_tree().current_scene = new_scene

	if current_scene:
		current_scene.queue_free()

	
	
