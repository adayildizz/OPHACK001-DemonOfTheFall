extends Node2D
class_name SteeringComponent

@export var actor : CharacterBody2D
@export var velocity_component : VelocityComponent
var num_bodies : int 
var bodies = []
var current_scene : Node2D
@export var max_force  : float

# Called when the node enters the scene tree for the first time.
func _ready():
	#for now
	current_scene = get_parent().get_parent()
	get_bodies_from_scene()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func alignment():
	var vector = Vector2.ZERO
	var count = 0
	
	for body in bodies:
		if body == actor:
			continue
		vector += body.velocity_component.velocity
		count += 1
	
	if count > 0:
		vector = vector.normalized() * max_force
	
	return vector
	
func seperation():
	pass
	
func cohesion():
	pass


func get_bodies_from_scene():
	var count = 0
	bodies = []
	var nodes = current_scene.get_children()
	for node in nodes:
		if node.is_in_group("bob"):
			bodies.append(node)
			count += 1
	num_bodies = count
	


