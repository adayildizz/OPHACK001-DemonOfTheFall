extends Node

var current_scene : Node2D
var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	current_scene = get_tree().current_scene
	print(current_scene)
	set_player()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func get_level_map():
	var tilemap : TileMap = get_tree().current_scene.find_child("TileMap")
	var ground = tilemap.get_used_cells(0)

	
func set_player():
	for child_node in current_scene.get_children():
		if child_node.is_in_group("player"):
			player = child_node

func set_enemies():
	for child_node in current_scene.get_children():
		if child_node.is_in_group("enemy"):
			child_node.set_victim()
