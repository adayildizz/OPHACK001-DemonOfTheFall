extends State
class_name BossChase

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
	handle_animations()
	
	
func _enter_state():
	print("in chase")
	set_physics_process(true)
	pathfind_component.is_enabled= true
	
	
	
	
func _exit_state():
	set_physics_process(false)



func _on_attack_area_body_entered(body):
	if body == actor.victim:
		back_to_attack.emit()


func chase():
	pathfind_component.update_target_vector(actor.victim.position)
	pathfind_component.follow_path(chase_speed)


func handle_animations():
	if actor.velocity == Vector2.ZERO: 
		
		animator.play("idle-front")
	else:
		if  actor.velocity.x > 0:
			animator.flip_h = true
			animator.play("move-sideview")
		elif  actor.velocity.x < 0:
			animator.flip_h = false
			animator.play("move-sideview")
		elif  actor.velocity == Vector2.UP:
			animator.play("move-back")
		elif  actor.velocity == Vector2.DOWN:
			animator.play("move-front")
