extends Control

@onready var email_input = $CenterContainer/PanelContainer/VBoxContainer/EmailInput
@onready var password_input = $CenterContainer/PanelContainer/VBoxContainer/PasswordInput
@onready var error_label = $CenterContainer/PanelContainer/VBoxContainer/ErrorLabel
@onready var login_button = $CenterContainer/PanelContainer/VBoxContainer/LoginButton
@onready var remember_checkbox = $CenterContainer/PanelContainer/VBoxContainer/RememberCheckBox

const SAVE_PATH = "user://login.cfg"

# Testdaten (später Server!)
var allowed_users = {
	"tom.jansen@gymsl.de": "1234"
}

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	login_button.pressed.connect(_on_login_pressed)
	check_auto_login()

func _on_login_pressed() -> void:
	var email = email_input.text.strip_edges()
	var password = password_input.text.strip_edges()

	if email in allowed_users and allowed_users[email] == password:
		error_label.text = ""

		if remember_checkbox.button_pressed:
			save_login(email)
		else:
			clear_saved_login()

		get_tree().change_scene_to_file("res://Scenes/MainMenu/MainMenu.tscn")
	else:
		error_label.text = "E-Mail oder Passwort falsch."

# Speichern, später Server!

func save_login(email: String) -> void:
	var config = ConfigFile.new()
	config.set_value("login", "email", email)
	config.save(SAVE_PATH)


func check_auto_login() -> void:
	var config = ConfigFile.new()
	var err = config.load(SAVE_PATH)

	if err == OK:
		var saved_email = config.get_value("login", "email", "")
		if saved_email != "":
			get_tree().change_scene_to_file("res://Scenes/MainMenu/MainMenu.tscn")


func clear_saved_login() -> void:
	var config = ConfigFile.new()
	config.erase_section("login")
	config.save(SAVE_PATH)
