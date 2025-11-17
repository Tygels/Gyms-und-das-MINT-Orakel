extends Node2D

@onready var startButton = $MainButtons/StartButton
@onready var exitButton = $MainButtons/ExitButton
signal exit_button_pressed

func _ready():
	# Connect signals
	startButton.pressed.connect(_on_startButton_pressed)
	exitButton.pressed.connect(_on_exitButton_pressed)
# Functions for each button
func _on_startButton_pressed():
	get_node("/root/Interaktion/MainButtons").visible = !get_node("/root/Interaktion/MainButtons").visible
	get_node("/root/Interaktion/ChatUI").visible = !get_node("/root/Interaktion/ChatUI").visible
func _on_exitButton_pressed():
	
	emit_signal("exit_button_pressed")
