extends State
class_name SoulHurtState
@onready var animator = $"../../AnimatedSprite2D"

signal state_to_move

@export var actor: CharacterBody2D
@onready var health_component = $"../../HealthComponent"
@onready var cool_down_timer = $"../../CoolDownTimer"
@onready var hit_flash = $"../../HitFlash"

@export var speed: float

func _ready():
	set_physics_process(false)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	actor.seek_and_wander(delta, speed)

func _enter_state():
	print("in hurt")
	set_physics_process(true)
	hurt()
	
	
func _exit_state():
	set_physics_process(false)
	

func hurt():
	cool_down_timer.start()
	hit_flash.play("hit_flash")
	actor.velocity = Vector2.ZERO
		



func _on_cool_down_timer_timeout():
	set_physics_process(true)
	print("TIMEDOUT")
	if health_component.should_be_dead():
		health_component.simply_die()
	else:
		state_to_move.emit()
