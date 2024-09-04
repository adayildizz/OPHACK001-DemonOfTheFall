extends State
class_name AttackState0

signal back_to_chase

@export var actor : CharacterBody2D
@export var pathfind : PathFindComponent
@export var velocity_component : VelocityComponent
@export var animator : AnimatedSprite2D

@export var attack_speed : float
@export var attack_acc : float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#attack()
	pass

func _enter_state():
	print("in attack")
	set_physics_process(true)
	animator.play("prepare_attack")
	
	
func _exit_state():
	set_physics_process(false)
	

func attack():
	if actor:
		if actor.victim:
			var dir = (actor.victim.global_position - actor.global_position).normalized()
			velocity_component.accelerate_in_direction(dir, attack_speed, attack_acc)
			velocity_component.move(actor)
	
	
	


func _on_attack_area_body_exited(body):
	if body == actor.victim:
		back_to_chase.emit()
