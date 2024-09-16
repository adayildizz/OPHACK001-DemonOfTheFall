extends Node2D
class_name World

const TILE_SIZE = 32

signal change_world

@export var this_world_path : String
@export var next_world_path : String
@export var enemy_count : int 
@export var enemy_type : String
@export var tree_count : int
@export var scene_width : int = 30
@export var scene_height : int = 22

@export var game_ui : GameUI
@export var entry_door : ExitDoor
@export var exit_door : ExitDoor
@export var tile_map : TileMap
@export var grass_walker : Walker 
@export var hills_walker : Walker

@export var theme : int 

var enemy_scene = preload("res://characters/souls/Soul.tscn")
var trees_scene = preload("res://objects/trees/Tree0.tscn")

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
