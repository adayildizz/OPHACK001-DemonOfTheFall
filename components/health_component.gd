extends Node2D
class_name HealthComponent

signal health_changed
signal body_died

@export var death_effect : Node2D
@export var animator : AnimatedSprite2D

@export var actor : CharacterBody2D
@export var hitflash_animator : AnimationPlayer

@onready var cool_down_timer = $"../CoolDownTimer"

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
	animator.stop()
	death_effect.create_death_effect()
	body_died.emit()
	
	

func take_damage( damage_rate : float):
	health_remaining -= damage_rate
	health_changed.emit()
	if hitflash_animator:
		hitflash_animator.play("hit_flash")
		
	print(actor, "took damage. Remaining: ", health_remaining)
	
func initialize_health():
	health_remaining = max_health
	
	
func should_be_dead():
	if health_remaining <= 0:
		return true
	return false



