extends Panel

@onready var messages = $MarginContainer/MainVBox/ScrollContainer/Messages
@onready var input_field = $MarginContainer/MainVBox/InputArea/InputField
@onready var send_button = $MarginContainer/MainVBox/InputArea/SendButton

func _ready():
	_style_ui()
	send_button.pressed.connect(_on_send_pressed)
	input_field.text_submitted.connect(_on_text_submitted)

func _style_ui():
	# Hintergrund
	var panel_style = StyleBoxFlat.new()
	panel_style.bg_color = Color("#1e1f2b")
	panel_style.set_corner_radius_all(14)
	add_theme_stylebox_override("panel", panel_style)

func _on_send_pressed():
	if input_field.text.strip_edges() == "":
		return
		
	add_message(input_field.text, true)
	input_field.clear()

func _on_text_submitted(text):
	_on_send_pressed()

func add_message(text: String, is_player: bool):
	var bubble = Panel.new()
	var bubble_style = StyleBoxFlat.new()

	if is_player:
		bubble_style.bg_color = Color("#4b6cff")
	else:
		bubble_style.bg_color = Color("#3a3d55")

	bubble_style.set_corner_radius_all(12)
	bubble.add_theme_stylebox_override("panel", bubble_style)

	var label = Label.new()
	label.text = text
	label.autowrap_mode = TextServer.AUTOWRAP_WORD
	label.add_theme_color_override("font_color", Color.WHITE)

	bubble.add_child(label)
	label.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	label.offset_left = 12
	label.offset_top = 8
	label.offset_right = -12
	label.offset_bottom = -8

	var container = HBoxContainer.new()

	if is_player:
		container.add_spacer(true)
		container.add_child(bubble)
	else:
		container.add_child(bubble)
		container.add_spacer(true)

	messages.add_child(container)

	await get_tree().process_frame
	$MarginContainer/MainVBox/ScrollContainer.scroll_vertical = 9999
