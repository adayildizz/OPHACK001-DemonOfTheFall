extends Node
class_name VelocityComponent

@export var actor : CharacterBody2D
@export var max_speed: float
@export var default_acceleration_coefficient: float

var velocity : Vector2 
var position : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = actor.velocity
	
	position = actor.get_global_position()
	
	
func accelerate_to_velocity(new_velocity: Vector2, acceleration_coefficient: float = default_acceleration_coefficient):
	velocity = lerp(velocity, new_velocity, acceleration_coefficient)
	
func decelarate():
	accelerate_to_velocity(Vector2.ZERO, default_acceleration_coefficient)
	 
func accelerate_in_direction(direction: Vector2, speed: float, acceleration_coefficient: float = default_acceleration_coefficient):
	velocity = lerp(velocity, direction*speed, acceleration_coefficient)
	


func move(actor: CharacterBody2D):
	actor.velocity = velocity
	actor.move_and_slide()
	
func smooth_seek(delta, target_position, speed):
	position = lerp(position, target_position, delta*speed)
	actor.global_position = position


