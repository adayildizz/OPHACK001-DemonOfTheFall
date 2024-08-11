extends Area2D
class_name ExitDoor

@export var door_name :String
@export var next_level_path: String
@export var connected_door_name: String


func _on_body_entered(body):
	print("body entered")
	if body.is_in_group("player"):
		print("player detected") 
		SceneManager.go_to_next_level(next_level_path, connected_door_name)
		set_deferred("monitoring", false)
		
