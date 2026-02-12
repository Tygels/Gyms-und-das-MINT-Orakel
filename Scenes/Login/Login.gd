extends Control

@onready var email_input = $CenterContainer/PanelContainer/VBoxContainer/EmailInput
@onready var password_input = $CenterContainer/PanelContainer/VBoxContainer/PasswordInput
@onready var error_label = $CenterContainer/PanelContainer/VBoxContainer/ErrorLabel
@onready var login_button = $CenterContainer/PanelContainer/VBoxContainer/LoginButton


# Testdaten (später Server!)
var allowed_users = {
	"tom.jansen@gymsl.de": "1234"
}


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	login_button.pressed.connect(_on_login_pressed)


func _on_login_pressed() -> void:
	var email = email_input.text.strip_edges()
	var password = password_input.text.strip_edges()
	
	if email in allowed_users and allowed_users[email] == password:
		error_label.text = ""
		get_tree().change_scene_to_file("res://Scenes/MainMenu/MainMenu.tscn")
	else:
		error_label.text = "E-Mail oder Passwort falsch."
