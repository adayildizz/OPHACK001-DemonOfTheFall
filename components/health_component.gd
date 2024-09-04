extends Node2D
class_name HealthComponent

signal health_changed
signal simply_died


@export var actor : CharacterBody2D
@export var hitflash_animator : AnimationPlayer
@onready var hurt_time = $Timer

@export var max_health : int

var health_remaining : float 


# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_health()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func heal(healing_rate : float):
	pass
	
func isHealing():
	pass

func simply_die():
	if hitflash_animator:
		hitflash_animator.stop()
	simply_died.emit()
	actor.set_physics_process(false)
	actor.hide()
	actor.call_deferred("free")
	

func take_damage( damage_rate : float):

	health_remaining -= max_health*damage_rate
	if hitflash_animator:
		hitflash_animator.play("hit_flash")
	hurt_time.start()
	print(health_remaining)
	health_changed.emit()
	
		
	
		
	 
	
func initialize_health():
	health_remaining = max_health
	
	
func should_be_dead():
	if health_remaining <= 0:
		return true
	return false


func _on_timer_timeout():
	actor.set_physics_process(true)
	if should_be_dead():
		simply_die()


