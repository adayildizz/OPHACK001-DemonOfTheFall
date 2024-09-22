extends StaticBody2D
class_name ExitDoor

signal change_level_request

@export var door_name :String
@export var next_level_path: String
@export var connected_door_name: String

@export var area : Area2D

@export var is_enabled = true

func _ready():
	print("node is ready")


func _on_area_2d_body_entered(body):
	print("body detected")
	#if is_enabled:
	if body.is_in_group("player"):
		print("body is player")
		set_deferred("monitoring", false)
		SceneManager.player_health = body.health_component.health_remaining
		SceneManager.is_new_level = true
		SceneManager.level_count += 1
		change_level_request.emit()
