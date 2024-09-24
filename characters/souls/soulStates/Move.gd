extends State
class_name SoulMoveState


signal state_to_hurt

@onready var animator = $"../../AnimatedSprite2D"
@onready var movement_circle = $"../../MovementCircle"
@onready var velocity_component = $"../../VelocityComponent"
@export var actor : CharacterBody2D
@onready var wander_ray = $"../../WanderRay"
@onready var timer = $Timer

@onready var timer2 = $"../../Timer"

@export var speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(false)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if actor.victim and timer2.is_stopped():
		
		actor.seek_and_wander(delta, speed)


func _enter_state():
	print("in smooth")
	set_physics_process(true)
	animator.play("move")
	
	
func _exit_state():
	set_physics_process(false)
	





	
	

