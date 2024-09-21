extends State
class_name AngelHurt

@export var actor : CharacterBody2D
@export var health_component : HealthComponent
@onready var hurt_timer = $HurtTimer
@onready var hit_flash = $"../../HitFlash"

#actually, it does not matter where to turn. we will be checking vision cast in every frame again.
signal back_to_wander

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
	pass


func _on_hurt_timer_timeout():
	print("out hurt")
	hit_flash.stop()
	back_to_wander.emit()
	
	
func hurt():
	
	hurt_timer.start()
	hit_flash.play("hit_flash")
	actor.velocity = Vector2.ZERO
