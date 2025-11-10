extends Node

@onready var button = $xpot
@onready var Interaktion = $Interaktion

func _ready():
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	Interaktion.visible = !Interaktion.visible
