extends Control

# ===============================
# UI Nodes & Requests
# ===============================
@onready var lineEdit: LineEdit = $Ui2/LineEdit
@onready var textEdit: TextEdit = $Ui1/TextEdit
@onready var ai_request: HTTPRequest = $Ui3/Button/HTTPRequest
var log_request: HTTPRequest

# URLs
var ai_server_url := "http://85.215.207.221:11434/api/chat"
var log_server_url := "http://85.215.207.221:5000/api/json"

var last_user_question: String = ""
var prompt = ""

# Referenz für die Teacher_id (wird weiterhin vom Parent geholt)
@onready var Interaktion = get_node("../..")

# ===============================
# READY
# ===============================
func _ready() -> void:
	log_request = HTTPRequest.new()
	add_child(log_request)
	ai_request.request_completed.connect(_on_ai_request_request_completed)
	lineEdit.grab_focus()

# ===============================
# HILFSFUNKTION: Lehrername ermitteln
# ===============================
func get_teacher_name(id: int) -> String:
	match id:
		1: return "Herr Klinkhammer"
		2: return "Frau Bachhausen"
		3: return "Herr Achenbach"
		4: return "Herr Wagener"
		5: return "Herr Bloem"
		6: return "Herr Christogeoros"
		7: return "Frau Feldmann"
		8: return "Herr Heim"
		9: return "Frau Matoussi"
		10: return "Herr Schmieding"
		11: return "Herr Steinhoff"
		12: return "Herr Wutke"
		13: return "Herr Gropper"
		14: return "Herr Langer"
		_: return "Unbekannter Lehrer"

# ===============================
# KI FRAGE SENDEN
# ===============================
func ask_ai(user_question: String) -> void:
	var teacher_id = Interaktion.Teacher_id

	# Zuweisung der Lehrer-Prompts basierend auf der ID
	match teacher_id:
		1: prompt = "Du bist Herr Klinkhammer, Lehrer für Englisch, Religion und Deutsch. Gib niemals direkte Antworten, sondern Hinweise."
		2: prompt = "Du bist Frau Bachhausen, Lehrerin für Musik und Deutsch. Gib kreative Denkanstöße."
		3: prompt = "Du bist Herr Achenbach, Lehrer für Erdkunde, Informatik und Mathematik. Gib Hinweise."
		4: prompt = "Du bist Herr Wagener, Lehrer für Mathematik und Chemie. Gib Denkanstöße."
		5: prompt = "Du bist Herr Bloem, Lehrer für Mathe und Informatik. Erkläre Konzepte schrittweise."
		6: prompt = "Du bist Herr Christogeoros, Lehrer für Englisch und Geschichte."
		7: prompt = "Du bist Frau Feldmann, Lehrerin für Deutsch und Philosophie. Gib nur Denkanstöße."
		8: prompt = "Du bist Herr Heim, Lehrer für Mathematik und Biologie. Gib niemals das Endergebnis."
		9: prompt = "Du bist Frau Matoussi, Lehrerin für Spanisch und Deutsch."
		10: prompt = "Du bist Herr Schmieding, Lehrer für Religion und Latein."
		11: prompt = "Du bist Herr Steinhoff, Lehrer für Politik, Erdkunde und Sport."
		12: prompt = "Du bist Herr Wutke, Lehrer für Politik und Sozialwissenschaften."
		13: prompt = "Du bist Herr Gropper, Lehrer für Englisch und Philosophie."
		14: prompt = "Du bist Herr Langer, Lehrer für Physik und Mathematik."
		_: prompt = "Du bist ein hilfreicher Lehrer in einem Lernspiel."

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

	var error = ai_request.request(ai_server_url, headers, HTTPClient.METHOD_POST, body)
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
	var teacher_name = get_teacher_name(Interaktion.Teacher_id)
	
	_add_message_to_chat(teacher_name, ai_reply)
	send_log_to_server(last_user_question, ai_reply, teacher_name)

# ===============================
# LOGGING MIT GLOBALER SESSION ID
# ===============================
func send_log_to_server(user_question: String, ai_answer: String, teacher_name: String) -> void:
	var headers := ["Content-Type: application/json"]
	
	# Hier wird die ID aus deinem SaveManager Autoload genutzt
	var body := JSON.stringify({
		"chat_id": SaveManager.session_id, 
		"teacher_name": teacher_name,
		"user_question": user_question,
		"ai_answer": ai_answer,
		"timestamp": Time.get_datetime_string_from_system()
	})

	var error := log_request.request(log_server_url, headers, HTTPClient.METHOD_POST, body)
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
	textEdit.set_caret_line(textEdit.get_line_count())
	textEdit.scroll_vertical = textEdit.get_line_count()
