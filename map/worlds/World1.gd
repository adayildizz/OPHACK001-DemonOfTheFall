extends World
var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	print("World ONE")
	player = await SceneManager.set_player()
	add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
