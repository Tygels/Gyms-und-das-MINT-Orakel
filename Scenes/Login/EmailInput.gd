extends LineEdit

func _ready() -> void:
	placeholder_text = "Schul-E-Mail"
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	custom_minimum_size.y = 40
