extends Control

# ===============================
# UI Nodes (neue Struktur)
# ===============================
@onready var lineEdit: LineEdit = $Ui2/LineEdit
@onready var textEdit: TextEdit = $Ui1/TextEdit

# HTTP Requests
@onready var ai_request: HTTPRequest = $Ui3/Button/HTTPRequest
var log_request: HTTPRequest

# URLs
var ai_server_url := "http://85.215.207.221:11434/api/chat"
var log_server_url := "http://85.215.207.221:5000/api/json"

# letzte Frage speichern
var last_user_question: String = ""

# Referenz zum Hauptskript
@onready var Interaktion = get_node("../..")

# ===============================
# Lehrer Prompts
# ===============================
var prompt_Feldmann = "Du bist Frau Feldmann, Lehrerin für Deutsch und Philosophie in einem Lernspiel. Du darfst niemals direkte Lösungen geben. Gib nur Hinweise und Denkanstöße."
var prompt_Langer = "Du bist Herr Langer, Lehrer für Physik und Mathematik in einem Lernspiel. Du darfst niemals Ergebnisse oder fertige Rechnungen nennen. Gib nur Denkschritte."
var prompt_Klinkhammer = "Du bist Herr Klinkhammer, Lehrer für Englisch, Religion und Deutsch in einem Lernspiel. Gib niemals direkte Antworten, sondern Hinweise."
var prompt_Heim = "Du bist Herr Heim, Lehrer für Mathematik und Biologie in einem Lernspiel. Gib niemals das Endergebnis."
var prompt_Bachhausen = "Du bist Frau Bachhausen, Lehrerin für Musik und Deutsch in einem Lernspiel. Gib kreative Denkanstöße."
var prompt_Gropper = "Du bist Herr Gropper, Lehrer für Englisch und Philosophie in einem Lernspiel. Gib nur Denkansätze."
var prompt_Steinhoff = "Du bist Herr Steinhoff, Lehrer für Politik, Erdkunde und Sport in einem Lernspiel. Gib Hinweise und Fragen."
var prompt_Christogeoros = "Du bist Herr Christogeoros, Lehrer für Englisch und Geschichte in einem Lernspiel."
var prompt_Wagener = "Du bist Herr Wagener, Lehrer für Mathematik und Chemie in einem Lernspiel."
var prompt_Achenbach = "Du bist Herr Achenbach, Lehrer für Erdkunde, Informatik und Mathematik in einem Lernspiel."
var prompt_Matoussi = "Du bist Frau Matoussi, Lehrerin für Spanisch und Deutsch in einem Lernspiel."
var prompt_Schmieding = "Du bist Herr Schmieding, Lehrer für Religion und Latein in einem Lernspiel."
var prompt_Wutke = "Du bist Herr Wutke, Lehrer für Politik und Sozialwissenschaften in einem Lernspiel."
var prompt_Bloem = "Du bist Herr Bloem, Lehrer für Mathe und Informatik in einem Lernspiel."

var prompt = ""

# ===============================
# READY
# ===============================
func _ready() -> void:

	log_request = HTTPRequest.new()
	add_child(log_request)

	ai_request.request_completed.connect(_on_ai_request_request_completed)

	lineEdit.grab_focus()

# ===============================
# KI FRAGE SENDEN
# ===============================
func ask_ai(user_question: String) -> void:

	var teacher_id = Interaktion.Teacher_id

	match teacher_id:
		1: prompt = prompt_Klinkhammer
		2: prompt = prompt_Bachhausen
		3: prompt = prompt_Achenbach
		4: prompt = prompt_Wagener
		5: prompt = prompt_Bloem
		6: prompt = prompt_Christogeoros
		7: prompt = prompt_Feldmann
		8: prompt = prompt_Heim
		9: prompt = prompt_Matoussi
		10: prompt = prompt_Schmieding
		11: prompt = prompt_Steinhoff
		12: prompt = prompt_Wutke
		13: prompt = prompt_Gropper
		14: prompt = prompt_Langer
		_: prompt = "Du bist ein hilfreicher Lehrer."

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

	var ai_reply: String = json["message"]["content"]

	_add_message_to_chat("Lehrer", ai_reply)

	send_log_to_server(last_user_question, ai_reply)

# ===============================
# LOGGING
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

	# automatisch nach unten scrollen
	textEdit.set_caret_line(textEdit.get_line_count())
	textEdit.scroll_vertical = textEdit.get_line_count()
