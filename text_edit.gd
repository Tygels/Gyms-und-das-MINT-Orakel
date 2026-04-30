extends TextEdit

var config = ConfigFile.new()

func _ready():
	var err = config.load("user://scores.cfg")

	if err != OK:
		return

	var texter = config.get_value("Setting", "text", "")
	self.text = str(texter)
	print(texter)


func _on_button_pressed() -> void:
	config.set_value("Setting", "text", self.text)
	config.save("user://scores.cfg")
