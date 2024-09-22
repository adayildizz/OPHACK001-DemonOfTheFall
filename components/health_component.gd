extends Node2D
class_name HealthComponent

signal health_changed
signal body_died
@onready var timer = $Timer

@export var death_effect : Node2D
@export var animator : AnimatedSprite2D

@export var actor : CharacterBody2D
@export var hitflash_animator : AnimationPlayer

@export var max_health : int

var health_remaining : float 

var can_take_damage : bool = true
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
	animator.stop()
	death_effect.create_death_effect()
	print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSS")
	body_died.emit()
	
	

func take_damage( damage_rate : float):
	print("In take damage")
	if can_take_damage:
		health_remaining -= damage_rate
		health_changed.emit()
		if hitflash_animator:
			hitflash_animator.play("hit_flash")
		can_take_damage = false
		print(actor, "took damage. Remaining: ", health_remaining)
		timer.start()
	
func initialize_health():
	health_remaining = max_health
	
	
func should_be_dead():
	if health_remaining <= 0:
		return true
	return false





func _on_timer_timeout():
	can_take_damage = true
