extends Area2D

@export var damage_rate: float
@onready var collision_shape = $CollisionShape2D
@export var attack_timer: Timer
@export var opponent: String

signal attacked

func _ready():
	attacked.connect(_on_attack)

func _physics_process(delta):
	if Input.is_action_just_pressed("Attack"):
		attack_timer.start()
		print("emitted")
		attacked.emit()
	

func _on_attack():
	if self.has_overlapping_bodies():
		var bodies = self.get_overlapping_bodies()
		for body in bodies:
			if body.health_component:
				body.health_component.take_damage(damage_rate)
	
	if self.has_overlapping_areas():
		
		var areas = self.get_overlapping_areas()
		for area in areas:
			area.queue_free()
