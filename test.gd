extends Control

@onready var ai_request = $Button/HTTPRequest
@onready var button = $Button
@onready var lineEdit = $LineEdit
@onready var textEdit = $TextEdit

# 1. The URL from ngrok + the chat completion endpoint
var server_url = "https://unhatchable-scott-goniometrically.ngrok-free.dev/v1/chat/completions" 

func ask_ai(user_question: String):
	# 2. Prepare the headers
	var headers = ["Content-Type: application/json"]
	
	# 3. Prepare the data (JSON format compatible with OpenAI/Ollama)
	var body = JSON.stringify({
		"model": "llama3.2", # Or whatever model you downloaded
		"messages": [
			{"role": "system", "content": "Du bist ein Mathe Lehrer der nur Mathe Fragen beantwortet"},
			{"role": "user", "content": user_question}
		],
		"stream": false
	})
	
	# 4. Send the request
	print("Sending to AI...")
	var error = ai_request.request(server_url, headers, HTTPClient.METHOD_POST, body)
	
	if error != OK:
		print("An error occurred in the HTTP request.")

# 5. Handle the response
func _on_ai_request_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		var ai_reply = json["choices"][0]["message"]["content"]
		_add_message_to_chat("ai:", ai_reply)
		
	else:
		_add_message_to_chat("Server Error: ", str(response_code)) 


func _ready():
	# Connect the signal if not done in editor
	ai_request.request_completed.connect(_on_ai_request_request_completed)


func _on_button_pressed() -> void:
	var user_text = lineEdit.text.strip_edges()
	if(user_text != ""):
		_add_message_to_chat("Du", user_text)
		ask_ai(user_text)
		lineEdit.text = ""
	else:
		pass
		
func _on_line_edit_text_submitted(_new_text: String) -> void:
	var user_text = lineEdit.text.strip_edges()
	if(user_text != ""):
		_add_message_to_chat("Du", user_text)
		ask_ai(user_text)
		lineEdit.text = ""
	else:
		pass

func _add_message_to_chat(sender: String, message: String):
	# Append the message to the chat history
	textEdit.text += sender + ": " + message + "\n"
