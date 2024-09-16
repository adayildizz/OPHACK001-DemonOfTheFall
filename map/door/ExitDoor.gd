extends Area2D
class_name ExitDoor

signal change_level_request()

@export var door_name :String
@export var next_level_path: String
@export var connected_door_name: String


@export var is_enabled = true

func _ready():
	print("node is ready")

func _on_body_entered(body):
	#if is_enabled:
	if body.is_in_group("player"):
		#set_deferred("monitoring", false)
		change_level_request.emit()
			



