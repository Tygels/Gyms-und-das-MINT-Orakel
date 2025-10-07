extends Control

@onready var chat_box = $ChatBackground/Chat/TextBox
@onready var scroll: ScrollContainer = $ChatBackground/Chat
@onready var input_box = $InputBox
@onready var send_button = $SendButton
@onready var back_button = $BackButton

func _ready():
	send_button.pressed.connect(_on_send_pressed)
	back_button.pressed.connect(_on_back_pressed)

func _on_send_pressed() -> void:
	var user_text = input_box.text.strip_edges()
	if user_text == "":
		return

	_add_message("Du: " + user_text)
	input_box.text = ""


	var timer = get_tree().create_timer(2.0)
	await timer.timeout
	_fake_ai_response()

func _fake_ai_response():
	var reply = "KI: Ich kann dir noch nicht beantworten"
	_add_message(reply)



func _add_message(text: String):
	var label = Label.new()
	label.text = text
	label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	label.custom_minimum_size.x = chat_box.size.x   # match container width
	chat_box.add_child(label)
func _on_back_pressed():
	get_node("/root/Node2D/ButtonMenu/MainButtons").visible = !get_node("/root/Node2D/ButtonMenu/MainButtons").visible
	get_node("/root/Node2D/ButtonMenu/ChatUI").visible = !get_node("/root/Node2D/ButtonMenu/ChatUI").visible
