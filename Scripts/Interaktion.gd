extends Node2D

@onready var startButton = $MainButtons/StartButton
@onready var exitButton = $MainButtons/ExitButton
@onready var mainButtons = $MainButtons
@onready var chatUI = $ChatUI
@onready var backButton = $ChatUI/BackButton
signal exit_button_pressed
@onready var Spieler = get_node("../..")
@onready var Teacher_id = Spieler.Teacher_id

func _ready():
	# Connect signals
	startButton.pressed.connect(_on_startButton_pressed)
	exitButton.pressed.connect(_on_exitButton_pressed)
	backButton.pressed.connect(_on_backButton_pressed)
# Functions for each button
func _on_startButton_pressed():
	mainButtons.visible = !mainButtons.visible
	chatUI.visible = !chatUI.visible
	Teacher_id = Spieler.Teacher_id
func _on_exitButton_pressed():
	
	emit_signal("exit_button_pressed")
	

func _on_backButton_pressed():
	mainButtons.visible = !mainButtons.visible
	chatUI.visible = !chatUI.visible
	
	$ChatUI/Control/TextEdit.set_text("")
