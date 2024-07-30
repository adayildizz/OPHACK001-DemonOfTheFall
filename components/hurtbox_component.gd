extends Area2D
class_name HurtboxComponent

@export var actor : CharacterBody2D
@export var animator : AnimatedSprite2D
@export var victim : CharacterBody2D

#Fields should be set manually. If not, they will be assigned as actor's properties by default.
func _ready():
	if !actor:
		actor = owner
	if !animator:
		animator = actor.animator
	if !victim:
		victim = actor.victim
		
		
		
func _on_body_entered(body):
	#this condition will be changed after the player's attacks are defined.
	if body == victim:
		animator.play("hurt")
