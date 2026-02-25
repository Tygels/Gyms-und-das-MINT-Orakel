extends LineEdit

func _ready() -> void:
	placeholder_text = "Passwort"
	secret = true
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	custom_minimum_size.y = 40
