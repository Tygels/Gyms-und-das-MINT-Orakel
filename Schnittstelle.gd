extends Control

# Zwischenspeicher
var saved_question: String = ""
var saved_answer: String = ""

@onready var http_request: HTTPRequest = HTTPRequest.new()

func _ready() -> void:
	# Node hinzufügen
	add_child(http_request)

	# Chat-Node finden und verbinden
	var chat_ui = get_node("/root/Main/Control")  # ❗ Pfad anpassen, falls dein Node anders heißt
	chat_ui.qa_ready.connect(_on_qa_ready)

	http_request.request_completed.connect(_on_request_completed)


# ------------------------------------
# Signal vom Chat
# ------------------------------------
func _on_qa_ready(question: String, answer: String):
	if question != "":
		saved_question = question

	if answer != "":
		saved_answer = answer

		# Wenn wir beides haben → senden
		if saved_question != "" and saved_answer != "":
			send_question_answer(saved_question, saved_answer)

			# Zur Sicherheit zurücksetzen
			saved_question = ""
			saved_answer = ""


# ------------------------------------
# Backend senden
# ------------------------------------
func send_question_answer(question: String, answer: String) -> void:
	var payload := {
		"question": question,
		"answer": answer,
		"timestamp": Time.get_unix_time_from_system() * 1000
	}

	var json := JSON.stringify(payload)
	var headers := ["Content-Type: application/json"]

	http_request.request(
		"http://85.215.207.221:5000/api/json",
		headers,
		HTTPClient.METHOD_POST,
		json
	)


func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray):
	print("Backend Response:", response_code, body.get_string_from_utf8())
