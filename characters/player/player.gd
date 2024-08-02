extends CharacterBody2D
class_name Player 


var MAX_SPEED : float = 200.0
var friction = 500.0
var acceleration = 1000.0
var victim

@onready var animator = $AnimatedSprite2D
@onready var timer = $Timer

@onready var state_machine = $StateMachine
@onready var attack_area = $Area2D



var input = Vector2.ZERO



func _ready() -> void:
	
	
	state_machine.init(self)
	

func _physics_process(delta: float) -> void:
	
	state_machine.process_physics(delta, get_input())
	move_and_slide()


func get_input() -> Vector2:
	input.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	input.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))	
	
	
	
	return input.normalized()
	


func _on_timer_timeout():
	animator.play(state_machine.current_state.state_name)
	



func get_current_state():
	return state_machine.current_state



func check_attack():
	if Input.is_action_just_pressed("Attack"):
		#just testing the load logic
		#Save.load_game()
		animator.play("attack")
		timer.start()
		print(attack_area.has_overlapping_bodies())
		if attack_area.has_overlapping_bodies():
			var victims = attack_area.get_overlapping_bodies()
			print(victims)
			for vic in victims:
				if (vic != self) and (vic is CharacterBody2D):
					vic.find_child("HealthComponent").take_damage(0.2)
		
		return true
	return false
	
	
func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		#"current_health" : current_health,
		#"level" : level,
		#"is_alive" : is_alive,
		#"last_attack" : last_attack
	}
	return save_dict

#just testing the save logic
#func _on_button_pressed():
	#Save.save_game()
	#get_tree().quit()
