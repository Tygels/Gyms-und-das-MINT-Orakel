extends Control

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	_build_ui()


func _build_ui() -> void:
	var background = ColorRect.new()
	background.color = Color("#1e1f2b")
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(background)

	var center = CenterContainer.new()
	center.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(center)


	var panel = PanelContainer.new()
	panel.custom_minimum_size = Vector2(420, 0)
	center.add_child(panel)


	var panel_style = StyleBoxFlat.new()
	panel_style.bg_color = Color("#2a2d3e")
	panel_style.corner_radius_top_left = 12
	panel_style.corner_radius_top_right = 12
	panel_style.corner_radius_bottom_left = 12
	panel_style.corner_radius_bottom_right = 12
	panel_style.content_margin_left = 24
	panel_style.content_margin_right = 24
	panel_style.content_margin_top = 24
	panel_style.content_margin_bottom = 24
	panel.add_theme_stylebox_override("panel", panel_style)


	var vbox = VBoxContainer.new()
	vbox.alignment = BoxContainer.ALIGNMENT_CENTER
	vbox.add_theme_constant_override("separation", 18)
	panel.add_child(vbox)


	var title = Label.new()
	title.text = "GymS und das Mint-Orakel"
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 36)
	vbox.add_child(title)
	
	var start_button = _create_button("Spiel starten")
	start_button.pressed.connect(_on_start_pressed)
	vbox.add_child(start_button)

	var settings_button = _create_button("Einstellungen")
	vbox.add_child(settings_button)

	var quit_button = _create_button("Beenden")
	quit_button.pressed.connect(_on_quit_pressed)
	vbox.add_child(quit_button)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()



func _create_button(text_value: String) -> Button:
	var button = Button.new()
	button.text = text_value
	button.custom_minimum_size = Vector2(0, 48)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	

	var normal = StyleBoxFlat.new()
	normal.bg_color = Color("#4f6cff")
	normal.corner_radius_top_left = 8
	normal.corner_radius_top_right = 8
	normal.corner_radius_bottom_left = 8
	normal.corner_radius_bottom_right = 8
	

	var hover = StyleBoxFlat.new()
	hover.bg_color = Color("#6f86ff")
	hover.corner_radius_top_left = 8
	hover.corner_radius_top_right = 8
	hover.corner_radius_bottom_left = 8
	hover.corner_radius_bottom_right = 8
	

	var pressed = StyleBoxFlat.new()
	pressed.bg_color = Color("#3d56d4")
	pressed.corner_radius_top_left = 8
	pressed.corner_radius_top_right = 8
	pressed.corner_radius_bottom_left = 8
	pressed.corner_radius_bottom_right = 8

	button.add_theme_stylebox_override("normal", normal)
	button.add_theme_stylebox_override("hover", hover)
	button.add_theme_stylebox_override("pressed", pressed)
	button.add_theme_color_override("font_color", Color.WHITE)

	return button
