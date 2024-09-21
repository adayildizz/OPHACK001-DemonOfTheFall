extends State
class_name AngelAttack

#in attack state, random directions will continue to be selected. 
#but also, the angel trys to runaway from the player.

@export var chase_speed : float
var chase_vector = Vector2.RIGHT
#nodes of angel's needed
@onready var vision_cast = $"../../VisionCast"
@onready var wander_state = $"../Wander"
@onready var shooting_timer = $ShootingTimer
@onready var animator = $"../../AnimatedSprite2D"
@onready var health_component = $"../../HealthComponent"

@onready var movement_circle : MovementCircle = $"../../MovementCircle"
@onready var velocity_component : VelocityComponent = $"../../VelocityComponent"
@onready var path_find_component : PathFindComponent = $"../../PathFindComponent"
@onready var hurt_timer = $"../../HurtTimer"



# the bitcoin scene
var BitcoinBall = preload("res://objects/bitcoinball/BitcoinBall.tscn")
@onready var bullet_container = $"../../BulletContainer"
var can_shoot = true
var keep_distance : bool = false
var random_vector = Vector2.ZERO

@export var actor: CharacterBody2D

func _ready():
	health_component.health_changed.connect(on_hurt)
	set_physics_process(false)
	
func _enter_state():
	set_physics_process(true)

func _exit_state():
	set_physics_process(false)
	
func _physics_process(delta):
	chase_victim(delta)
	handle_animations()
	attack()


	
func attack():
	#send things to players position
	
	if can_shoot:
		var bitcoinball = BitcoinBall.instantiate()
		actor.find_child("BulletContainer").add_child(bitcoinball)
		bitcoinball.position = actor.fire_point.position
		can_shoot = false
		#wait to be able to shoot again.
		shooting_timer.start()
	
		

func handle_animations():
	if approximate_to_vector(vision_cast.target_position) == 2:
		animator.play("attack-back")
		return
	elif approximate_to_vector(vision_cast.target_position) == 6:
		animator.play("attack-front")
		return

	if vision_cast.target_position.x > 0:
		animator.flip_h = false
		animator.play("attack-sideview")
	elif vision_cast.target_position.x < 0:
		animator.flip_h = true
		animator.play("attack-sideview")
	
func approximate_to_vector(vector):
	var angle = atan2(vector.y, vector.x)
	var fraction = int(roundf(8 * (angle + PI) / (2 * PI))) % 8
	return fraction


func _on_shooting_timer_timeout():
	can_shoot = true
	



func get_victims_relative_position_vector():
	if actor.victim:
		var direction = (actor.victim.global_position - actor.global_position)
		return direction
	return Vector2.ZERO

func chase_victim(delta):
	chase_vector = -get_victims_relative_position_vector()
	
	if !keep_distance:	
		chase_vector = keep_dist_with_randomness(chase_vector, 100)
		
	chase_vector = add_avoidance(chase_vector, 200).normalized()
	var current_direction = actor.velocity.normalized()
	var smooth_direction = current_direction.slerp(chase_vector, 10 * delta)
	velocity_component.accelerate_in_direction(smooth_direction, chase_speed)
	velocity_component.move(actor)
	
		
	
	
func keep_dist_with_randomness(chase_vector : Vector2, weight:float):
	random_vector = chase_vector.rotated(randf_range(-PI / 2, PI / 2))
	var final_vector = (100* chase_vector.normalized() + weight*random_vector).normalized()
	return final_vector
	
	
func _on_area_2d_body_entered(body):
	keep_distance = true


func _on_area_2d_body_exited(body):
	keep_distance = false

func add_avoidance(vector, weight):
	var avoid_from = movement_circle.compute_avoidance_vector()
	var final_direction = (100*vector.normalized() + avoid_from*weight).normalized()
	return final_direction
	
func on_hurt():
	chase_speed = 10
	hurt_timer.start()


func _on_hurt_timer_timeout():
	chase_speed = 50
