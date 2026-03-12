extends Node2D

@onready var startButton = $MainButtons/StartButton
@onready var exitButton = $MainButtons/ExitButton
@onready var mainButtons = $MainButtons
@onready var chatUI = $ChatUI
@onready var backButton = $ChatUI/BackButton
signal exit_button_pressed
@onready var Spieler = get_node("../..")
@onready var Teacher_id = Spieler.Teacher_id
@onready var Teacher_sprite = $Lehrer

func _ready():
	# Connect signals
	startButton.pressed.connect(_on_startButton_pressed)
	exitButton.pressed.connect(_on_exitButton_pressed)
	backButton.pressed.connect(_on_backButton_pressed)


# Functions for each button
func _on_startButton_pressed():
	mainButtons.visible = !mainButtons.visible
	chatUI.visible = !chatUI.visible
func _on_exitButton_pressed():
	
	emit_signal("exit_button_pressed")
	

func _on_backButton_pressed():
	mainButtons.visible = !mainButtons.visible
	chatUI.visible = !chatUI.visible
	$ChatUI/Control/TextEdit.set_text("")


func _on_spieler_interact() -> void:
	var Teacher_portrait = null
	Teacher_id = Spieler.Teacher_id
	match Teacher_id:
		1:
			Teacher_portrait = load("res://Dateien/Klinkhammer.png")
		2:
			Teacher_portrait = load("res://Dateien/Bachhausen2.png")
		3:
			Teacher_portrait = load("res://Dateien/Achenbach.png")
		4:
			Teacher_portrait = load("res://Dateien/Dr. Wagener Icon-default.png")
		5:
			Teacher_portrait = load("res://Dateien/Bloem.png")
		6:
			Teacher_portrait = load("res://Dateien/Christogeoros.png")
		7:
			Teacher_portrait = load("res://Dateien/Feldmann.png")
		8:
			Teacher_portrait = load("res://Dateien/Heim.png")
		9:
			Teacher_portrait = load("res://Dateien/Matoussi.png")
		10:
			Teacher_portrait = load("res://Dateien/Schmieding.png")
		11:
			Teacher_portrait = load("res://Dateien/Steinhoff.png")
		12:
			Teacher_portrait = load("res://Dateien/Wutke.png")
		13:
			Teacher_portrait = load("res://Dateien/Gropper.png")
		14:
			Teacher_portrait = load("res://Dateien/Langerklein.png")
	Teacher_sprite.set_texture(Teacher_portrait)
