extends Area2D

var actor : CharacterBody2D
@export var damage_rate: float
@export var opponent : String
@onready var collision_shape = $CollisionShape2D


func _ready():
	actor = get_parent()
	
	actor.attacked.connect(_on_attack)
	

func _on_attack():
	if self.has_overlapping_bodies():
		var bodies = self.get_overlapping_bodies()
		for body in bodies:
			if body.is_in_group(opponent):
				if body.health_component:
					body.health_component.take_damage(damage_rate)
	
	if self.has_overlapping_areas():
		
		var areas = self.get_overlapping_areas()
		for area in areas:
			area.queue_free()
