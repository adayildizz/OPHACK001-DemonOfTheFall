extends Area2D
class_name ExitDoor

signal player_entered_door()

@export var door_name :String
@export var next_level_path: String
@export var connected_door_name: String

@export var is_enabled = true

func _ready():
	print("node is ready")

func _on_body_entered(body):
	if is_enabled:
		if body.is_in_group("player"):
			set_deferred("monitoring", false)
			SceneManager.change_scene(next_level_path)
			#Save.save_game(Save.game_number)



