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

#the fsm states
@onready var fsm = $FiniteStateMachine
@onready var soul_move_state = $FiniteStateMachine/SoulMoveState
@onready var soul_hurt_state = $FiniteStateMachine/SoulHurtState


@export var victim : CharacterBody2D

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
	var target_position =  victim.get_global_position()
	var seeking_velocity = (target_position - get_global_position()).normalized()*100
	wander_direction = wander_direction.rotated(randf_range(-PI / 4, PI / 4)).normalized()
	var final_direction = (seeking_velocity + wander_power*wander_direction).normalized()
	var current_direction = velocity.normalized()
	var smooth_direction = current_direction.slerp(final_direction, 10 * delta)

	# Update velocity and move
	velocity_component.accelerate_in_direction(smooth_direction, speed, acceleration_coefficient)
	velocity_component.move(self)


func _on_wander_timer_timeout():
	wander_direction = Vector2(1,0).rotated(randf_range(0,2*PI))
