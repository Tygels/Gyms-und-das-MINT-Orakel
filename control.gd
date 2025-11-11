extends Control

@onready var chat_history = $ChatHistory
@onready var player_input = $PlayerInput
@onready var send_button = $SendButton
@onready var http_request = $HTTPRequest

var openai_api_key = "YOUR_API_KEY_HERE"
var openai_url = "https://api.openai.com/v1/completions"

func _ready():
	send_button.pressed.connect(_on_send_button_pressed)
	_add_message_to_chat("AI", "Hello, traveler! How can I assist you today?")

func _on_send_button_pressed():
	var player_message = player_input.text.strip_edges()
	if player_message != "":
		_add_message_to_chat("Player", player_message)
		player_input.clear()
		_send_to_ai(player_message)

func _add_message_to_chat(sender: String, message: String):
	chat_history.text += "[" + sender + "]: " + message + "\n"
	chat_history.caret_position = chat_history.text.length()  # Scroll to bottom

func _send_to_ai(player_message: String):
	
	
	
func _on_request_completed(result: int, response_code: int, headers: Array, body: PackedByteArray) -> void:
	if response_code == 200:
		var body_text = body.get_string_from_utf8()
		var json = JSON.new()
		var err = json.parse(body_text)
		if err != OK:
			_add_message_to_chat("AI", "Oops! Something went wrong with the AI response.")
			return
		
		var response_json = json.get_result()
		if response_json.has("error"):
			_add_message_to_chat("AI", "AI Error: " + str(response_json.error.message))
			return
		
		var ai_message = ""
		if response_json.has("choices") and response_json.choices.size() > 0:
			ai_message = response_json.choices[0].text.strip_edges()
		
		_add_message_to_chat("AI", ai_message)
	else:
		_add_message_to_chat("AI", "There was an error connecting to the AI service.")
