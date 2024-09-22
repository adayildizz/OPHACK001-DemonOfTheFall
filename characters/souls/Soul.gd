extends CharacterBody2D
class_name Soul

signal attacked

var wander_direction = Vector2(1,0)

@export var wander_power : float 
@export var acceleration_coefficient: float

#here is the child components
@onready var animator = $AnimatedSprite2D
@onready var health_component = $HealthComponent
@onready var velocity_component = $VelocityComponent
@onready var movement_circle = $MovementCircle

#the fsm states
@onready var fsm = $FiniteStateMachine
@onready var soul_move_state = $FiniteStateMachine/SoulMoveState
@onready var soul_hurt_state = $FiniteStateMachine/SoulHurtState


@export var victim : CharacterBody2D
@export var death_effect : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	health_component.health_changed.connect(fsm.change_state.bind(soul_hurt_state))
	soul_hurt_state.state_to_move.connect(fsm.change_state.bind(soul_move_state))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_victim(new_victim: CharacterBody2D):
	victim = new_victim



	

func _on_hitbox_component_body_entered(body):
	attacked.emit()



func seek_and_wander(delta, speed):
	var target_position =  await victim.get_global_position()
	
	var seeking_velocity = (target_position - get_global_position()).normalized()*100
	wander_direction = wander_direction.rotated(randf_range(-PI / 4, PI / 4)).normalized()
	var randomized_direction = (seeking_velocity + wander_power*wander_direction).normalized()
	var final_direction = add_avoidance(randomized_direction, 1)
	var current_direction = velocity.normalized()
	var smooth_direction = current_direction.slerp(final_direction, 10 * delta)
	
	# Update velocity and move
	velocity_component.accelerate_in_direction(smooth_direction, speed, acceleration_coefficient)
	velocity_component.move(self)


func _on_wander_timer_timeout():
	wander_direction = Vector2(1,0).rotated(randf_range(0,2*PI))



func add_avoidance(vector, weight):
	var avoid_from = movement_circle.compute_avoidance_vector()
	var final_direction = vector + avoid_from*weight
	return final_direction
	
	

func save():
	var save_dict = {
		"filename" : get_scene_file_path(),
		"parent" : get_parent().get_scene_file_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"current_health" : health_component.health_remaining,
		"victim": victim
		#"last_attack" : last_attack
	}
	return save_dict
