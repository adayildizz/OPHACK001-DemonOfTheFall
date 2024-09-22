extends State
class_name WanderState0

@export var actor : CharacterBody2D
@export var animator : AnimatedSprite2D
@export var pathfind : PathFindComponent
@export var velocity_component : VelocityComponent
@export var movement_circle : MovementCircle

@export var wander_speed : float

signal back_to_chase
signal back_to_attack

@onready var stop_timer = $Stop
@onready var start_timer = $Start

var wander_direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	


	
func _physics_process(delta):
	#pathfind.follow_path(wander_speed)
	wander()
	
func _enter_state():
	print("in wander")
	set_physics_process(true)
	animator.play("idle")
	
	stop_timer.start()
	
	

	
func _exit_state():
	set_physics_process(false)
	stop_timer.stop()
	start_timer.stop()
	


func _on_chase_area_body_entered(body):
	if body == actor.victim:
		pathfind.is_chasing_victim = true
		back_to_chase.emit()
		


func wander():
	if stop_timer.is_stopped():
	
		velocity_component.accelerate_in_direction(wander_direction, wander_speed)
		velocity_component.move(actor)
	


func _on_start_timeout():
	stop_timer.start()
	print("idling")
	animator.play("idle")


func _on_stop_timeout():
	wander_direction = movement_circle.choose_random_direction()
	start_timer.start()
	print("moving", wander_direction)
	animator.play("move")
