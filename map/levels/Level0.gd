extends Node2D
@onready var audio2d = $AudioStreamPlayer2D
@export var absolute_path: String


# Called when the node enters the scene tree for the first time.
func _ready():
	audio2d.play()
	SceneManager.spawn_player("level0_door0")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
