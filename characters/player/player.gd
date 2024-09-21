extends CharacterBody2D
class_name Player 
#Player Layer is the layer 0.

#Limit velocity for the character 
@export var MAX_SPEED : float


signal attacked


#Child nodes
@onready var animator = $AnimatedSprite2D
@onready var attack_timer = $AttackTimer
@onready var hitbox = $Hitbox
@export var state_machine : FSM_0
@export var health_component : HealthComponent
@onready var hit_flash = $HitFlash
@onready var player_cam = $Camera2D

#For two player moods "geto" and "rika"
@export var mood : String

#For player movement and animations 
var input = Vector2.ZERO
var prev_input = Vector2.DOWN


func _ready() -> void:
	state_machine.init(self)
	health_component.health_changed.connect(_on_hurt)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Attack"):
		attack_timer.start()
		print("player attacking")
		attacked.emit()
		
	handle_animations()
	state_machine.process_physics(delta, get_input())
	move_and_slide()


func get_input() -> Vector2:
	input.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	input.y = int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))	
	
	return input.normalized()
	

func _on_timer_timeout():
	#attack animation overrides other animations 
	animator.play(state_machine.current_state.state_name)
	

#func get_current_state():
	#return state_machine.current_state

	
func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_scene_file_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"current_health" : health_component.health_remaining,
		#"is_alive" : is_alive,
		#"last_attack" : last_attack
	}
	return save_dict


func handle_animations():
	# Attack animation takes priority
	if !attack_timer.is_stopped():
		if prev_input.x > 0:
			hitbox.rotation = 0
			hitbox.position = Vector2(2, 0)
			animator.flip_h = true
			animator.play("attack-sideview-{mood}".format({"mood": mood}))
		elif prev_input.x < 0:
			hitbox.rotation = 0
			hitbox.position = Vector2(-2, 0)
			animator.flip_h = false
			animator.play("attack-sideview-{mood}".format({"mood": mood}))
		elif prev_input == Vector2.DOWN:
			animator.play("attack-front-{mood}".format({"mood": mood}))
			hitbox.rotation = PI/2
			hitbox.position = Vector2(0, 2)
		elif prev_input == Vector2.UP:
			animator.play("attack-back-{mood}".format({"mood": mood}))
			hitbox.rotation = PI/2
			hitbox.position = Vector2(0, 0)
		# Return early to avoid playing other animations
		return  

	# Idle state
	if input == Vector2.ZERO:
		if prev_input.x > 0:
			animator.flip_h = true
			animator.play("idle-sideview-{mood}".format({"mood": mood}))
		elif prev_input.x < 0:
			animator.flip_h = false
			animator.play("idle-sideview-{mood}".format({"mood": mood}))
		elif prev_input == Vector2.DOWN:
			animator.play("idle-front-{mood}".format({"mood": mood}))
		elif prev_input == Vector2.UP:
			animator.play("idle-back-{mood}".format({"mood": mood}))
	# Moving state
	else:
		if velocity.x > 0:
			animator.flip_h = true
			animator.play("move-sideview-{mood}".format({"mood": mood}))
		elif velocity.x < 0:
			animator.flip_h = false
			animator.play("move-sideview-{mood}".format({"mood": mood}))
		elif velocity.normalized() == Vector2.UP:
			animator.play("move-back-{mood}".format({"mood": mood}))
		elif velocity.normalized() == Vector2.DOWN:
			animator.play("move-front-{mood}".format({"mood": mood}))
	
	# Update prev_input to store the last non-zero input direction
	if input != Vector2.ZERO:
		prev_input = input



func _on_hurt():
	hit_flash.play("hit_flash")
	



func _on_hit_flash_animation_finished(anim_name):
	hit_flash.stop()
