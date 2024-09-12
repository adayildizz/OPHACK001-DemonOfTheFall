class_name MainMenu

extends Control

@onready var start_button = $StartButton as Button
@onready var options_button = $OptionsButton as Button
@onready var exit_button = $QuitButton as Button
#Since packedscenes did not worked for me, I am adding absolute paths
@export var gametype_menu : String
@export var options_menu : String


# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.button_down.connect(_on_start_button_pressed);
	options_button.button_down.connect(_on_options_button_pressed);
	exit_button.button_down.connect(_on_exit_button_pressed);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#for now, starts from the beginning.
func _on_start_button_pressed():
	SceneManager.change_scene(gametype_menu)
	

func _on_options_button_pressed():
	SceneManager.change_scene(options_menu)

func _on_exit_button_pressed():
	SceneManager.quit_without_saving_game()
