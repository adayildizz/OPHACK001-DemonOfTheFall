extends State
class_name BossHurt

@export var actor : CharacterBody2D
@export var health_component : HealthComponent
@export var movement_circle : MovementCircle
@export var velocity_component : VelocityComponent

@onready var hurt_timer = $HurtTimer
@onready var hit_flash = $"../../HitFlash"
@export var hurt_speed : float
var vector : Vector2
#actually, it does not matter where to turn. we will be checking vision cast in every frame again.
signal back_to_attack

func _ready():
	set_physics_process(false)
	

	
func _enter_state():
	print("in hurt")
	
	if health_component.should_be_dead():
		health_component.simply_die()
	else:
		set_physics_process(true)
		hurt()
	
	
func _exit_state():
	set_physics_process(false)
	
func _physics_process(delta):
	run_away(delta)


func _on_hurt_timer_timeout():
	print("out hurt")
	hit_flash.stop()
	health_component.can_take_damage = true
	back_to_attack.emit()
	
	
func hurt():
	hurt_timer.start()
	hit_flash.play("hit_flash")


func run_away(delta):
	vector = -actor.get_victims_relative_position()
	vector = add_avoidance(vector, 200).normalized()
	var current_direction = actor.velocity.normalized()
	var smooth_direction = current_direction.slerp(vector, 10 * delta)
	velocity_component.accelerate_in_direction(smooth_direction, hurt_speed)
	velocity_component.move(actor)
	
func add_avoidance(vector, weight):
	var avoid_from = movement_circle.compute_avoidance_vector()
	var final_direction = (100*vector.normalized() + avoid_from*weight).normalized()
	return final_direction
