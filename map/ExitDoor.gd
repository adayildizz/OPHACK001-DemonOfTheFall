extends Area2D
class_name ExitDoor

signal change_level


func _on_body_entered(body):
	if body.is_in_group("player"):
		change_level.emit()
		
