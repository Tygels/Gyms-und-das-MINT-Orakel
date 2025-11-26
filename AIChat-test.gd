extends Control

signal qa_ready(question: String, answer: String)

@onready var http_request: HTTPRequest = HTTPRequest.new()
@onready var button = $Button
@onready var lineEdit = $LineEdit
@onready var textEdit = $TextEdit

var url = "https://meowfacts.herokuapp.com/"
var last_user_question: String = ""


func _ready() -> void:
	# HTTPRequest dem SceneTree hinzufügen
	add_child(http_request)
	http_request.request_completed.connect(_on_http_request_completed)

	# Buttons verbinden
	button.pressed.connect(_on_button_pressed)
	lineEdit.text_submitted.connect(_on_line_edit_text_submitted)


# ------------------------------
# USER EINGABE
# ------------------------------
func _on_button_pressed() -> void:
	_process_user_input()


func _on_line_edit_text_submitted(_new_text: String) -> void:
	_process_user_input()


func _process_user_input() -> void:
	var user_text = lineEdit.text.strip_edges()

	if user_text == "":
		return

	# Im Chatfenster anzeigen
	_add_message_to_chat("Du", user_text)

	# Frage speichern
	last_user_question = user_text

	# 🔥 Signal senden (Frage)
	emit_signal("qa_ready", last_user_question, "")

	# API-Abfrage starten
	http_request.request(url)

	lineEdit.text = ""


# ------------------------------
# API ANTWORT EMPFANGEN
# ------------------------------
func _on_http_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code != 200:
		_add_message_to_chat("KI", "Fehler bei der API.")
		return

	var data = JSON.parse_string(body.get_string_from_utf8())
	var response = data.data[0]

	_add_message_to_chat("KI", response)

	# 🔥 Signal senden (Antwort)
	emit_signal("qa_ready", "", response)


# ------------------------------
# CHAT DARSTELLUNG
# ------------------------------
func _add_message_to_chat(sender: String, message: String):
	textEdit.text += sender + ": " + message + "\n"
