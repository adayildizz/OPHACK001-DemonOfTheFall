extends Node2D
class_name MapComponent

var current_scene : Node2D

var map : Array

func set_map():
	current_scene = get_parent().get_parent()
	if current_scene:
		
		map = current_scene.map


func compute_rand_coords():
	return map[randi() % map.size()]
