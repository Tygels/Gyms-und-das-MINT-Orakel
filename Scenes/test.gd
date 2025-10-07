extends Node

@onready var button = $xpot

func _ready():
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Interaktion.tscn")
