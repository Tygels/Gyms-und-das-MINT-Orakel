extends ColorRect

func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	color = Color("#1e1f2b") # dunkler, moderner Hintergrund
