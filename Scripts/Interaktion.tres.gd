extends Node

@onready var startButton = $MainButtons/StartButton
@onready var exitButton = $MainButtons/ExitButton

func _ready():
	# Connect signals
	startButton.pressed.connect(_on_startButton_pressed)
	exitButton.pressed.connect(_on_exitButton_pressed)
# Functions for each button
func _on_startButton_pressed():
	$MainButtons.visible = !$MainButtons.visible
	$ChatUI.visible = !$ChatUI.visible
	
	
func _on_exitButton_pressed():
	get_tree().change_scene("res://Default.tscn")
