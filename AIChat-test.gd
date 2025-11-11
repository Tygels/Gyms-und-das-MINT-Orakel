extends Control

@onready var http_request = $Button/HTTPRequest
@onready var button = $Button
@onready var lineEdit = $LineEdit
@onready var textEdit = $TextEdit

var api = ""
var url = "https://meowfacts.herokuapp.com/" 

func _on_button_pressed() -> void:
	var user_text = lineEdit.text.strip_edges()
	if(user_text != ""):
		_add_message_to_chat("Du", user_text)
		http_request.request(url)
		lineEdit.text = ""
	else:
		pass


func _on_line_edit_text_submitted(new_text: String) -> void:
	var user_text = lineEdit.text.strip_edges()
	if(user_text != ""):
		_add_message_to_chat("Du", user_text)
		http_request.request(url)
		lineEdit.text = ""
	else:
		pass

func _on_http_request_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var data = JSON.parse_string(body.get_string_from_utf8())
	var response = data.data[0]
	_add_message_to_chat("KI", response)

func _add_message_to_chat(sender: String, message: String):
	# Append the message to the chat history
	textEdit.text += sender + ": " + message + "\n"
