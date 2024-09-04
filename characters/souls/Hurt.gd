extends State
class_name SoulHurtState
@onready var animator = $"../../AnimatedSprite2D"

signal state_to_move

func _ready():
	set_physics_process(false)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	pass

func _enter_state():
	print("in hurt")
	set_physics_process(true)
	animator.play("hurt")
	
	
func _exit_state():
	set_physics_process(false)
	
