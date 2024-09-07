extends Node2D

#var Soul = preload("res://characters/souls/Soul.tscn")
#var Angel = preload("res://characters/angels/Angel.tscn")

@onready var grass = $Grass
@onready var texture_progress_bar = $CanvasLayer/TextureProgressBar
@onready var camera_2d = $Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#Spawn the player into the scene
	var player = SceneManager.spawn_player("entry_door")
	
	

	#enemy.set_inner_map(map)
	#enemy.find_child("PathFindComponent").call_deferred("compute_rand_coords")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
