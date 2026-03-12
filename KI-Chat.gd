extends Control

# UI Nodes - Pfade an neue Struktur angepasst
@onready var button: Button = $Button
@onready var lineEdit: LineEdit = $Ui2/LineEdit    # Pfad korrigiert: liegt jetzt in Ui2
@onready var textEdit: TextEdit = $Ui1/TextEdit    # Pfad korrigiert: liegt jetzt in Ui1

# HTTP Requests
@onready var ai_request: HTTPRequest = $Ui3/Button/HTTPRequest
var log_request: HTTPRequest

# URLs
var ai_server_url := "http://85.215.207.221:11434/api/chat"
var log_server_url := "http://85.215.207.221:5000/api/json"

# Speicher für letzte Frage
var last_user_question: String = ""

# Referenz auf das übergeordnete Interaktion-Skript
@onready var Interaktion = get_node("../..")

var prompt_Mathe = "Du bist ein Mathe Lehrer der nur Mathe Fragen beantwortet"
var prompt_Englisch = "Du bist ein Englisch Lehrer der nur Englisch Fragen beantwortet"
var prompt_Physik = "Du bist ein Physik Lehrer der nur Physik Fragen beantwortet"
var prompt = null

func _ready() -> void:
	# Zweite HTTPRequest für Logging
	log_request = HTTPRequest.new()
	add_child(log_request)

	# Signale verbinden
	ai_request.request_completed.connect(_on_ai_request_request_completed)
	
	# Optional: Fokus direkt auf das Eingabefeld setzen
	lineEdit.grab_focus()

# ===============================
# KI FRAGE SENDEN
# ===============================
func ask_ai(user_question: String) -> void:
	# Prompts nach ID ändern
	var teacher_id = Interaktion.Teacher_id
	
	match teacher_id:
		1:
			prompt = prompt_Mathe
		2:
			prompt = prompt_Englisch
		3:
			prompt = prompt_Physik
		_:
			prompt = "Du bist ein hilfreicher Assistent."

	last_user_question = user_question

	var headers = ["Content-Type: application/json"]
	var body := JSON.stringify({
		"model": "llama3.2",
		"messages": [
			{"role": "system", "content": prompt},
			{"role": "user", "content": user_question}
		],
		"stream": false
	})

	print("Sende Anfrage an KI...")
	var error = ai_request.request(
		ai_server_url,
		headers,
		HTTPClient.METHOD_POST,
		body
	)

	if error != OK:
		_add_message_to_chat("System", "❌ Fehler beim Senden an die KI")

# ===============================
# KI ANTWORT EMPFANGEN
# ===============================
func _on_ai_request_request_completed(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code != 200:
		_add_message_to_chat("System", "KI-Server Fehler: " + str(response_code))
		return

	var json : Variant = JSON.parse_string(body.get_string_from_utf8())
	if json == null:
		_add_message_to_chat("System", "Ungültige KI-Antwort")
		return

	var ai_reply: String = json["message"]["content"]
	_add_message_to_chat("Lehrer", ai_reply) # "KI" durch "Lehrer" ersetzt für mehr Atmosphäre

	# Logging an zweiten Server
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
		print("❌ Fehler beim Logging")

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
	
	# Automatisches Scrollen nach ganz unten
	textEdit.set_caret_line(textEdit.get_line_count())
	textEdit.scroll_vertical = textEdit.get_line_count()
