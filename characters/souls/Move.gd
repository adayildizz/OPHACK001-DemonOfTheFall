extends State
class_name SoulMoveState


signal state_to_hurt

@onready var animator = $"../../AnimatedSprite2D"
@onready var movement_circle = $"../../MovementCircle"
@onready var velocity_component = $"../../VelocityComponent"
@export var actor : CharacterBody2D
@onready var wander_ray = $"../../WanderRay"
@onready var timer = $Timer


var wander_direction = Vector2(1,0)
@export var wander_power : float 

@export var speed: float
@export var acceleration_coefficient: float

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if actor.victim:
		seek_and_wander(delta)


func _enter_state():
	print("in smooth")
	set_physics_process(true)
	animator.play("move")
	
	
func _exit_state():
	set_physics_process(false)
	

func seek_and_wander(delta):
	var target_position =  actor.victim.get_global_position()
	var seeking_velocity = (target_position - actor.get_global_position()).normalized()*100
	
	wander_direction = wander_direction.rotated(randf_range(-PI / 4, PI / 4)).normalized()
	var final_direction = (seeking_velocity + wander_power*wander_direction).normalized()
	var current_direction = actor.velocity.normalized()
	var smooth_direction = current_direction.slerp(final_direction, acceleration_coefficient * delta)

	# Update velocity and move
	velocity_component.accelerate_in_direction(smooth_direction, speed, acceleration_coefficient)
	velocity_component.move(actor)


func _on_timer_timeout():
	wander_direction = Vector2(1,0).rotated(randf_range(0,2*PI))
	

