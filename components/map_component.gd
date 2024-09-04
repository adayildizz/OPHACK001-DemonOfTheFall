extends Node2D
class_name MapComponent

#This component deals with the map of the current scene to organize the movements of the actor

var map : Array

@export var wander_scope : int 
@export var actor : CharacterBody2D

func get_current_scene():
	return get_parent().get_parent()

func set_map():
	if get_current_scene():
		map = get_current_scene().map
		
		
func get_tile_map():
	if get_current_scene():
		return get_current_scene().find_child("TileMap")
	return

func create_wander_navigation_mesh():
	var new_navigation_mesh = NavigationPolygon.new()
	add_child(new_navigation_mesh)
	
	
	
	
	
