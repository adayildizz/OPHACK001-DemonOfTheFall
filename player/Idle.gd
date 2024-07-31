extends P_state

@export
var run_state: P_state
@export
var die_state: P_state
@onready var timer = $"../../Timer"
var state_name = "idle"

func enter() -> void:
	if timer.is_stopped():
		player.animator.play(state_name)
	

func process_physics(delta: float,input: Vector2) -> P_state:
	
	player.check_attack()
		
	if input != Vector2.ZERO:
		return run_state
	return null

func exit() -> void:
	player.animator.stop()



