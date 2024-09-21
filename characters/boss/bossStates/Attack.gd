extends State
class_name BossAttack

signal back_to_chase
@export var actor : CharacterBody2D
@export var attack_speed : float
@onready var animator = $"../../AnimatedSprite2D"
@onready var path_find_component = $"../../PathFindComponent"
@onready var dash_timer = $DashTimer

var can_dash : bool = true

func _ready():
	set_physics_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	dash(delta)
	handle_animations()
	

func _enter_state():
	print("in boss chase")
	set_physics_process(true)
	path_find_component.is_enabled = false
	dash_timer.start()
	

	
func _exit_state():
	set_physics_process(false)
	
	
func get_victims_relative_position():
	return actor.to_local(actor.victim.position - actor.position)

func dash(delta):
	if can_dash:
		print("can dash now")
		var point = actor.victim.position - actor.position
		print("dash position: ", point)
		actor.position = lerp(actor.position, point, delta*4.0)
		can_dash = false
		dash_timer.start()
	

func handle_animations():
	if approximate_to_vector(get_victims_relative_position()) == 2:
		animator.play("attack-back")
		return
	elif approximate_to_vector(get_victims_relative_position()) == 6:
		animator.play("attack-front")
		return

	if get_victims_relative_position().x > 0:
		animator.flip_h = false
		animator.play("attack-sideview")
	elif get_victims_relative_position().x < 0:
		animator.flip_h = true
		animator.play("attack-sideview")
	
	
func approximate_to_vector(vector):
	var angle = atan2(vector.y, vector.x)
	var fraction = int(roundf(8 * (angle + PI) / (2 * PI))) % 8
	return fraction



func _on_area_2d_body_exited(body):
	path_find_component.is_enabled = true
	back_to_chase.emit()


func _on_dash_timer_timeout():
	can_dash = true
	
	
