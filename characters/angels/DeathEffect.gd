extends Node2D

signal death_animation_finished

@export var animation : String
@export var actor : CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var particles = $CPUParticles2D

func _ready():
	animated_sprite.visible = false


func create_death_effect():
	animated_sprite.visible = true
	animated_sprite.play(animation)
	particles.gravity = Vector2(0, -490)



func _on_animated_sprite_2d_animation_finished():
	print("ANIMATION FINISHED")
	death_animation_finished.emit()
	actor.set_physics_process(false)
	actor.hide()
	actor.call_deferred("free")
