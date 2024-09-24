extends State
class_name BossIdle
signal back_to_chase
@onready var animator = $"../../AnimatedSprite2D"
@onready var waiting_timer = $WaitingTimer

func _ready():
	set_physics_process(false)
	

	
func _enter_state():
	set_physics_process(true)
	waiting_timer.start()
	animator.play("idle-front")
	
	
func _exit_state():
	set_physics_process(false)
	
	

func _physics_process(delta):
	#handle_animations()
	#wander if the angel is not seeing the player directly.
	#attack otherwise
	pass
	


func _on_waiting_timer_timeout():
	back_to_chase.emit()
