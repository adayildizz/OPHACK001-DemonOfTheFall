extends Node2D
class_name PathFindComponent

@export var the_map : Array
var is_enabled : bool = true
## The Actor is the enemy scene itself
@export var actor : CharacterBody2D

@onready var nav = $NavigationAgent2D

## Velocity component of the character body 
@export var velocity_component : VelocityComponent
@export var movement_circle : MovementCircle


#Component's timer node
@onready var timer = $Timer

# target vector used to update navigation target position
var target_vector = Vector2.ZERO

#for the states : Why not a signal? -> this is being checked in _physics_process of states
var is_chasing_victim : bool = false


#handling the map
var current_scene : Node2D
var tilemap : TileMap


func _ready():
	pass
	
		
# Since the position of the victim must be checked in every frame, rather than signals, 
#I am using a var. 
func _physics_process(delta):
	pass
		
func follow_path(speed : float, acceleration_coefficient : float = velocity_component.default_acceleration_coefficient):
	if is_enabled:
		if target_vector != Vector2.ZERO:
			nav.target_position = target_vector
			
		if nav.is_navigation_finished():
			velocity_component.decelarate()
			
			print("finished")
		#print("AA", nav.target_position)
		var direction = ((nav.get_next_path_position() - actor.global_position) ).normalized()
		
		#print("following direction: ", direction)
		velocity_component.accelerate_in_direction(direction, speed, acceleration_coefficient)
		nav.set_velocity(velocity_component.velocity)
		
		velocity_component.move(actor)
	


func _on_velocity_computed(safe_velocity : Vector2):
	var new_direction = safe_velocity.normalized()
	var current_direction = velocity_component.velocity.normalized()
	var halfway = lerp(current_direction, new_direction, 0.2)
	velocity_component.velocity = halfway * velocity_component.velocity.length()
	
	
func _on_navigation_agent_2d_target_reached():
	if is_chasing_victim:
		#this will be modified
		pass
		
		
func update_target_vector(new_vector : Vector2):
	target_vector = new_vector
		

#
