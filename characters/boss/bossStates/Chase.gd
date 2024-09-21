extends State
class_name BossChase

@onready var path_find_component = $"../../PathFindComponent"
@onready var velocity_component = $"../../VelocityComponent"
@onready var movement_circle = $"../../MovementCircle"
@onready var animator = $"../../AnimatedSprite2D"
@export var actor : CharacterBody2D
@export var chase_speed : float 

signal back_to_attack

func _ready():
	set_physics_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	chase()
	handle_animations()


func _enter_state():
	print("in boss chase")
	set_physics_process(true)
	animator.play("run")
	
	
	
	
func _exit_state():
	set_physics_process(false)
	

func chase():
	print("CHAAAASSSEEE")
	if actor.victim:
		print("where is victim")
		var final_vector = add_avoidance(actor.victim.position, 100)
		path_find_component.update_target_vector(final_vector)
		path_find_component.follow_path(chase_speed)
	else:
		print("no victim")

func add_avoidance(vector : Vector2, weight):
	var avoid_from = movement_circle.compute_avoidance_vector()
	return vector + weight*avoid_from


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		back_to_attack.emit()
		
		

func handle_animations():
	if actor.velocity == Vector2.ZERO:
		animator.play("idle-front")
	else:
		if actor.velocity.x >= 0:
			animator.play("move-sideview")
		elif actor.velocity.x < 0:
			animator.play("move-sideview")
			animator.flip_h = true
		else:
			if actor.velocity.y >= 0:
				animator.play("move-front")
			if actor.velocity.y < 0:
				animator.play("move-back")
	
