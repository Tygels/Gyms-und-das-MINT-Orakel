extends Control

# UI Nodes
@onready var button: Button = $Button
@onready var lineEdit: LineEdit = $LineEdit
@onready var textEdit: TextEdit = $TextEdit

# HTTP Requests
@onready var ai_request: HTTPRequest = $Button/HTTPRequest
var log_request: HTTPRequest

# URLs
var ai_server_url := "https://unhatchable-scott-goniometrically.ngrok-free.dev/v1/chat/completions"
var log_server_url := "https://mediocre-uncapturable-giselle.ngrok-free.dev/api/json"

# Speicher für letzte Frage
var last_user_question: String = ""

func _ready() -> void:
	# Zweite HTTPRequest für Logging
	log_request = HTTPRequest.new()
	add_child(log_request)

	# Signale verbinden
	ai_request.request_completed.connect(_on_ai_request_request_completed)
	button.pressed.connect(_on_button_pressed)
	lineEdit.text_submitted.connect(_on_line_edit_text_submitted)

# ===============================
# KI FRAGE SENDEN
# ===============================
func ask_ai(user_question: String) -> void:
	last_user_question = user_question

	var headers := ["Content-Type: application/json"]

	var body := JSON.stringify({
		"model": "llama3.2",
		"messages": [
			{"role": "system", "content": "Du bist ein Mathe Lehrer der nur Fragen aus dem Fach Mathe beantwortet, die Antworten sollten möglichst kurz gehalten werden"},
			{"role": "user", "content": user_question}
		],
		"stream": false
	})

	print("Sende Anfrage an KI...")
	var error := ai_request.request(
		ai_server_url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)

	if error != OK:
		print("❌ Fehler beim Senden an die KI")

# ===============================
# KI ANTWORT EMPFANGEN
# ===============================
func _on_ai_request_request_completed(
	_result: int,
	response_code: int,
	_headers: PackedStringArray,
	body: PackedByteArray
) -> void:

	if response_code != 200:
		_add_message_to_chat("System", "KI-Server Fehler: " + str(response_code))
		return

	var json : Variant = JSON.parse_string(body.get_string_from_utf8())
	if json == null:
		_add_message_to_chat("System", "Ungültige KI-Antwort")
		return

	var ai_reply: String = json["choices"][0]["message"]["content"]
	_add_message_to_chat("KI", ai_reply)

	# 🔴 Logging an zweiten Server
	send_log_to_server(last_user_question, ai_reply)

# ===============================
# LOGGING AN SERVER SENDEN
# ===============================
func send_log_to_server(user_question: String, ai_answer: String) -> void:
	var headers := ["Content-Type: application/json"]
	var timestamp := Time.get_datetime_string_from_system()

	var body := JSON.stringify({
		"user_question": user_question,
		"ai_answer": ai_answer,
		"timestamp": timestamp
	})

	var error := log_request.request(
		log_server_url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)

	if error != OK:
		print("❌ Fehler beim Senden an Logging-Server")

# ===============================
# UI EVENTS
# ===============================
func _on_button_pressed() -> void:
	_submit_user_text()

func _on_line_edit_text_submitted(_text: String) -> void:
	_submit_user_text()

func _submit_user_text() -> void:
	var user_text := lineEdit.text.strip_edges()

	if user_text == "":
		return

	_add_message_to_chat("Du", user_text)
	ask_ai(user_text)
	lineEdit.text = ""

# ===============================
# CHAT ANZEIGE
# ===============================
func _add_message_to_chat(sender: String, message: String) -> void:
	textEdit.text += sender + ": " + message + "\n"
