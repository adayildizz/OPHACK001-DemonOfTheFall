extends Control

@onready var go_back_button = $MarginContainer/HBoxContainer/VBoxContainer/Go_Back_Button as Button
@onready var main_menu = preload("res://UI/Main_Menu.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	go_back_button.button_down.connect(on_go_back_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_go_back_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)
