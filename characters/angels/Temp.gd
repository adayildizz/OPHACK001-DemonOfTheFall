extends State
class_name Temp


func _ready():
	set_physics_process(false)
	

	
func _enter_state():
	print("ENTERED")
	set_physics_process(true)
	
	
func _exit_state():
	set_physics_process(false)
	
	

func _physics_process(delta):
	print("this I am seeing ")
	
	
	
