extends Node2D

@onready var chatUI = $ChatUI
@onready var backButton = $ChatUI/Backbutton/BackButton
signal exit_button_pressed
@onready var Spieler = get_node("../..")
@onready var Teacher_id = Spieler.Teacher_id
@onready var Teacher_sprite = $Lehrer

func _ready():
	# Connect signals

	backButton.pressed.connect(_on_backButton_pressed)
	
	_apply_chat_font()
	
	
func _apply_chat_font():
	var pixel_font = load("res://Dateien/PixeloidSans.ttf")

	# ===== CHATVERLAUF (TextEdit) =====
	var text_edit = $ChatUI/Control/Ui1/TextEdit
	text_edit.add_theme_font_override("font", pixel_font)
	text_edit.add_theme_font_size_override("font_size", 38)
	
	var text_color = Color("ffffffff")
	text_edit.add_theme_color_override("font_readonly_color", text_color)
	text_edit.add_theme_color_override("font_outline_color", text_color)
	text_edit.add_theme_constant_override("outline_size", 2)

	# ===== INPUT FELD (LineEdit) =====
	var line_edit = $ChatUI/Control/Ui2/LineEdit
	line_edit.add_theme_font_override("font", pixel_font)
	line_edit.add_theme_font_size_override("font_size", 40)
	line_edit.add_theme_color_override("font_color", Color("#111111"))
	line_edit.add_theme_color_override("font_placeholder_color", Color("000000ff"))
	
	

func _on_backButton_pressed():

	emit_signal("exit_button_pressed")


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
