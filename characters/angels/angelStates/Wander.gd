extends State
class_name AngelWander

#parent
@onready var actor = $"../.."
#sibling nodes
@onready var animator = $"../../AnimatedSprite2D"
@onready var vision_cast = $"../../VisionCast"
#child nodes
@onready var waiting_timer = $WaitingTimer
@onready var moving_timer = $MovingTimer
#states
@onready var attack_state = $"../Attack"
#components
@onready var movement_circle = $"../../MovementCircle"
@onready var velocity_component = $"../../VelocityComponent"

#random direction to move in wander state
var wander_direction = Vector2.ZERO
#speed to move in wander state
@export var wander_speed : float

func _ready():
	set_physics_process(false)
	

	
func _enter_state():
	set_physics_process(true)
	waiting_timer.start()
	animator.play("idle-front")
	
	
func _exit_state():
	set_physics_process(false)
	
	

func _physics_process(delta):
	handle_animations()
	#wander if the angel is not seeing the player directly.
	#attack otherwise
	if !moving_timer.is_stopped():
		wander()
	
	



func wander():
	velocity_component.accelerate_in_direction(wander_direction,wander_speed)
	velocity_component.move(actor)
	



func _on_waiting_timer_timeout():
	moving_timer.start()
	wander_direction = movement_circle.choose_random_direction()
	
	


func _on_moving_timer_timeout():
	waiting_timer.start()
	
	
	
	
	
func handle_animations():
	if actor.velocity == Vector2.ZERO: 
		if wander_direction.x > 0:
			animator.play("idle-sideview")
		elif wander_direction.x < 0:
			animator.flip_h = true
			animator.play("idle-sideview")
		elif wander_direction == Vector2.UP:
			animator.play("idle-back")
		elif wander_direction == Vector2.DOWN:
			animator.play("idle-front")
	else:
		if wander_direction.x > 0:
			animator.play("move-sideview")
		elif wander_direction.x < 0:
			animator.flip_h = true
			animator.play("move-sideview")
		elif wander_direction == Vector2.UP:
			animator.play("move-back")
		elif wander_direction == Vector2.DOWN:
			animator.play("move-front")
