extends Node2D
class_name PathFindComponent

@export var the_map : Array

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
var is_attacking_victim : bool = false

#handling the map
var current_scene : Node2D
var tilemap : TileMap


func _ready():
	pass
	
		
# Since the position of the victim must be checked in every frame, rather than signals, 
#I am using a var. 
func _physics_process(delta):
	if is_chasing_victim and actor.victim:
		target_vector = actor.victim.global_position
		
		
func follow_path(speed : float, acceleration_coefficient : float = velocity_component.default_acceleration_coefficient):
	print("speed: ", speed)
	print("target: ", target_vector)
	if target_vector != Vector2.ZERO:
		nav.target_position = target_vector
		#print(nav.target_position)
	if nav.is_navigation_finished():
		velocity_component.decelarate()
		
		print("finished")
	#print("AA", nav.target_position)
	var direction = ((nav.get_next_path_position() - actor.global_position) ).normalized()
	print("direction: ", nav.get_next_path_position())
	velocity_component.accelerate_in_direction(direction, speed, acceleration_coefficient)
	nav.set_velocity(velocity_component.velocity)
	#print(direction)
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
		
		



func random_location_from_map():
	#print("WTF", the_map)
	if the_map.size() == 0:
		return Vector2.ZERO
	var random_index = (randi() % the_map.size())
	var random_cell = the_map[random_index] 

	return random_cell
	
func compute_rand_coords():
	var rand_cell = random_location_from_map()
	var rand_coords = Vector2i(rand_cell.x, rand_cell.y) *32
	target_vector = rand_coords
	print("New random target vector set: ", target_vector)

