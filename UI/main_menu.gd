class_name MainMenu

extends Control

@onready var start_button = $MarginContainer/HBoxContainer/VBoxContainer/StartButton as Button
@onready var options_button = $MarginContainer/HBoxContainer/VBoxContainer/OptionsButton as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/QuitButton as Button
@onready var start_level = preload("res://map/levels/Level0.tscn") as PackedScene
@onready var options = preload("./OptionsUI/Options.tscn") as PackedScene


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
	#SceneManager.start_game()
	get_tree().change_scene_to_packed(start_level)

func _on_options_button_pressed():
	get_tree().change_scene_to_packed(options)

func _on_exit_button_pressed():
	SceneManager.quit_without_saving_game()


