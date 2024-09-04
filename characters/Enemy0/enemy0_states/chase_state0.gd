extends State
class_name ChaseState0


signal back_to_wander
signal back_to_attack
signal chase_victim

@export var actor: CharacterBody2D
@export var animator : AnimatedSprite2D
@export var pathfind_component : PathFindComponent
@export var chase_speed : float 

func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	chase()
	
	
func _enter_state():
	print("in chase")
	set_physics_process(true)
	animator.play("move")
	
	
	
	
func _exit_state():
	set_physics_process(false)



	
func _on_chase_area_body_exited(body):
	print("GONE")
	if body == actor.victim:
		pathfind_component.is_chasing_victim = false
		pathfind_component.compute_rand_coords()
		back_to_wander.emit()




func _on_attack_area_body_entered(body):
	if body == actor.victim:
		back_to_attack.emit()


func chase():
	pathfind_component.follow_path(chase_speed)
