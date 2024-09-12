extends Control

@onready var new_game_button = $NewGameButton
@onready var continue_button = $ContinueButton
@onready var back_button = $BackButton

@export var main_menu : String


func _on_new_game_button_button_down():
	pass # Replace with function body.


func _on_continue_button_button_down():
	Save.load_game()


func _on_back_button_button_down():
	SceneManager.change_scene(main_menu)
