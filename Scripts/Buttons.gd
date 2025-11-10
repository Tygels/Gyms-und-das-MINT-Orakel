extends Node

@onready var PlayButton = $Button
@onready var ExitButton = $Button2

func _ready():
	PlayButton.pressed.connect(_on_playButton_pressed)
	ExitButton.pressed.connect(_on_exitButton_pressed)


func _on_playButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_exitButton_pressed():
	get_tree().quit()
