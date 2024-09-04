extends CharacterBody2D
class_name Player 

#Player Layer is the layer 0.

var MAX_SPEED : float = 150.0
var victim

var animator : AnimatedSprite2D
@onready var animatorGeto = $Geto
@onready var animatorRika = $Rika

@onready var attack_timer = $AttackTimer
@onready var hitbox = $Hitbox
@onready var state_machine = $StateMachine
@onready var health_component = $HealthComponent

@export var mood : String



var input = Vector2.ZERO
var prev_input = Vector2.DOWN


func _ready() -> void:
	set_animator(mood)
	state_machine.init(self)
	

func _physics_process(delta: float) -> void:
	handle_animations()
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




	
func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		#"current_health" : current_health,
		#"is_alive" : is_alive,
		#"last_attack" : last_attack
	}
	return save_dict



func add_player_cam():
	var player_cam = Camera2D.new()
	add_child(player_cam)

func handle_animations():
	# Attack animation takes priority
	if !attack_timer.is_stopped():
		if prev_input.x > 0:
			hitbox.rotation = 0
			hitbox.position = Vector2(2, 0)
			animator.flip_h = true
			animator.play("attack-sideview")
		elif prev_input.x < 0:
			hitbox.rotation = 0
			hitbox.position = Vector2(-2, 0)
			animator.flip_h = false
			animator.play("attack-sideview")
		elif prev_input == Vector2.DOWN:
			animator.play("attack-front")
			hitbox.rotation = PI/2
			hitbox.position = Vector2(0, 2)
		elif prev_input == Vector2.UP:
			animator.play("attack-back")
			hitbox.rotation = PI/2
			hitbox.position = Vector2(0, 0)
		return  # Return early to avoid playing other animations

	# Idle state
	if input == Vector2.ZERO:
		if prev_input.x > 0:
			animator.flip_h = true
			animator.play("idle-sideview")
		elif prev_input.x < 0:
			animator.flip_h = false
			animator.play("idle-sideview")
		elif prev_input == Vector2.DOWN:
			animator.play("idle-front")
		elif prev_input == Vector2.UP:
			animator.play("idle-back")
	# Moving state
	else:
		if velocity.x > 0:
			animator.flip_h = true
			animator.play("move-sideview")
		elif velocity.x < 0:
			animator.flip_h = false
			animator.play("move-sideview")
		elif velocity.normalized() == Vector2.UP:
			animator.play("move-back")
		elif velocity.normalized() == Vector2.DOWN:
			animator.play("move-front")
	
	# Update prev_input to store the last non-zero input direction
	if input != Vector2.ZERO:
		prev_input = input


func set_animator(mood):
	if mood == "Geto":
		animator = animatorGeto
		animatorGeto.visible = true
		animatorRika.visible = false
	else:
		animator = animatorRika
		animatorRika.visible = true
		animatorGeto.visible = false
	

