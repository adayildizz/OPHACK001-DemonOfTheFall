extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#for now, starts from the beginning.
func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://levels/Level0.tscn")

func _on_options_button_pressed():
	var options = load("res://UI/Options.tscn")
	get_tree().current_scene.add_child(options)

func _on_quit_button_pressed():
	get_tree().quit()


