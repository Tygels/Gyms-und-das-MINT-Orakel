extends Node

@onready var startButton = $MainButtons/StartButton
@onready var exitButton = $MainButtons/ExitButton

func _ready():
	# Connect signals
	startButton.pressed.connect(_on_startButton_pressed)
	exitButton.pressed.connect(_on_exitButton_pressed)
	$ChatUI.visible = false
# Functions for each button
func _on_startButton_pressed():
	$MainButtons.visible = !$MainButtons.visible
	$ChatUI.visible = !$ChatUI.visible
	
	
func _on_exitButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Default.tscn")
