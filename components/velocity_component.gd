extends Node
class_name VelocityComponent

@export var actor : CharacterBody2D
@export var max_speed: float
@export var acceleration_coefficient: float

var velocity : Vector2 


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = actor.velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func accelerate_to_velocity(new_velocity: Vector2):
	velocity = lerp(velocity, new_velocity, acceleration_coefficient)
	
func decelarate():
	accelerate_to_velocity(Vector2.ZERO)
	 
func accelerate_in_direction(direction: Vector2, speed: float):
	velocity = lerp(velocity, direction*speed, acceleration_coefficient)
	
	

func move(actor: CharacterBody2D):
	actor.velocity = velocity
	actor.move_and_slide()
	

