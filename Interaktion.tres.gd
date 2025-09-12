extends Node

@onready var button1 = $Button
@onready var button2 = $Button2
@onready var button3 = $Button3
@onready var button4 = $Button4

func _ready():
	# Connect signals
	button1.pressed.connect(_on_button1_pressed)
	button2.pressed.connect(_on_button2_pressed)
	button3.pressed.connect(_on_button3_pressed)
	button4.pressed.connect(_on_button4_pressed)
# Functions for each button
func _on_button1_pressed():
	print("Button 1 pressed → calling function A")


func _on_button2_pressed():
	print("Button 2 pressed → calling function B")


func _on_button3_pressed():
	print("Button 3 pressed → calling function C")


func _on_button4_pressed():
	print("Button 4 pressed → calling function D")
