extends Control

@onready var startButton = $StartButton
@onready var exitButton = $ExitButton

func _ready():
	# Connect signals
	startButton.pressed.connect(_on_startButton_pressed)
	exitButton.pressed.connect(_on_exitButton_pressed)
# Functions for each button
func _on_startButton_pressed():
	get_node("/root/Interaktion/MainButtons").visible = !get_node("/root/Interaktion/MainButtons").visible
	get_node("/root/Interaktion/ChatUI").visible = !get_node("/root/Interaktion/ChatUI").visible
func _on_exitButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Default.tscn")
