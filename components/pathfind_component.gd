extends Node2D
class_name PathFindComponent

#When intializing this node do not forget to connect the areas 


#The Actor and its nodes:
@export var actor : CharacterBody2D
@onready var nav = $NavigationAgent2D


#Actor's components
@export var velocity_component : VelocityComponent
@export var map_component : MapComponent

#Actor's victim
@export var victim : CharacterBody2D

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
	map_component.set_map()
	target_vector = map_component.compute_rand_coords()
	print("target",target_vector)
	if !victim:
		victim = actor.victim
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if is_chasing_victim:
		target_vector = victim.global_position
		


func follow_path(speed : float):
	
	if target_vector:
		nav.target_position = target_vector*32
	
	
	if nav.is_navigation_finished():
		velocity_component.decelarate()
		#print("finished")
		
	var direction = (nav.get_next_path_position() - actor.global_position).normalized()
	#print(direction)
	#the speed must be the speed of the current state
	velocity_component.accelerate_in_direction(direction, speed)
	nav.set_velocity(velocity_component.velocity)
	velocity_component.move(actor)



func _on_velocity_computed(safe_velocity : Vector2):
	var new_direction = safe_velocity.normalized()
	var current_direction = velocity_component.velocity.normalized()
	var halfway = lerp(current_direction, new_direction, 0.2)
	velocity_component.velocity = halfway * velocity_component.velocity.length()
	
	
func _on_navigation_agent_2d_target_reached():
	
	if !is_chasing_victim:
		#this will be modified
		target_vector = map_component.compute_rand_coords()
		print("GOT YA")
	
		
	return

func _on_chase_area_body_entered(body):
	if body == victim:
		is_chasing_victim = true
		target_vector = actor.victim.global_position


func _on_chase_area_body_exited(body):
	if body == victim:
		is_chasing_victim = false
		target_vector = map_component.compute_rand_coords()



func set_target_vector():
	pass
