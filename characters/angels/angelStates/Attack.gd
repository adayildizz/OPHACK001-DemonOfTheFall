extends State
class_name AngelAttack

@export var runaway_speed : float
@onready var path_find_component = $"../../PathFindComponent"
@onready var vision_cast = $"../../VisionCast"
@onready var wander_state = $"../Wander"
@onready var shooting_timer = $ShootingTimer

@onready var animator = $"../../AnimatedSprite2D"

# the bitcoin scene
var BitcoinBall = preload("res://objects/bitcoinball/BitcoinBall.tscn")
@onready var bullet_container = $"../../BulletContainer"
var can_shoot = true

@export var actor: CharacterBody2D

func _ready():
	set_physics_process(false)
	
func _enter_state():
	set_physics_process(true)

func _exit_state():
	set_physics_process(false)
	
func _physics_process(delta):
	
	handle_animations()
	attack()
	if !can_shoot:
		run_away()
	
	
	
	
	
func attack():
	#send things to players position
	
	if can_shoot:
		var bitcoinball = BitcoinBall.instantiate()
		actor.find_child("BulletContainer").add_child(bitcoinball)
		bitcoinball.position = actor.fire_point.position
		can_shoot = false
		#wait to be able to shoot again.
		shooting_timer.start()
		#await get_tree().create_timer(3).timeout
		
	
		

func run_away():
	path_find_component.is_chasing_victim = true
	path_find_component.follow_path(runaway_speed)
	
	
	
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
