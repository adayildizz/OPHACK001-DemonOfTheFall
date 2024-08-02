extends P_state
@onready var timer = $"../../Timer"

@export
var idle_state: P_state
@export
var die_state: P_state

var state_name = "move"

func enter() -> void:
	if timer.is_stopped():
		player.animator.play(state_name)
	

func process_physics(delta: float, input: Vector2) -> P_state:
	
	player.check_attack()
		
	if player.velocity.x < 0:
		player.animator.flip_h = true
	if player.velocity.x > 0:
		player.animator.flip_h = false
	
	if input == Vector2.ZERO:
		if player.velocity.length() > (player.friction*delta):
			player.velocity -= player.velocity.normalized() * (player.friction*delta)
		else:
			player.velocity = Vector2.ZERO
		
	else:
		player.velocity += (input*player.acceleration*delta)
		player.velocity = player.velocity.limit_length(player.MAX_SPEED)
	
	
		
		
	if player.velocity == Vector2.ZERO:
		return idle_state
		
	return null
	

func exit() -> void:
	player.animator.stop()




