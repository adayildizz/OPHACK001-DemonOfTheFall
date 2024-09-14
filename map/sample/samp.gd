extends Node2D
@onready var transition = $Transition

# Called when the node enters the scene tree for the first time.
func _ready():
	print("before")
	await get_tree().create_timer(0.1).timeout
	print("after")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
