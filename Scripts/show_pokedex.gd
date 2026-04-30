extends GridContainer

var npcsData

func _ready() -> void:
	npcsData = [
		{"name": "1", "texture": preload("res://Dateien/LehrerKarten/Klinkhammer-Karte.png")},
		{"name": "2", "texture": preload("res://Dateien/LehrerKarten/Bachhausen-Karte.png")},
		{"name": "3", "texture": preload("res://Dateien/LehrerKarten/Kartenvorlage.png")},
		{"name": "4", "texture": preload("res://Dateien/LehrerKarten/Feldmann-Karte.png")},
		{"name": "5", "texture": preload("res://Dateien/LehrerKarten/unerkannte-Karte.png")},
		{"name": "6", "texture": preload("res://Dateien/LehrerKarten/unerkannte-Karte.png")},
		{"name": "7", "texture": preload("res://Dateien/LehrerKarten/unerkannte-Karte.png")},
	
	]


func _on_button_button_up() -> void:
	# 1. Clear existing children (so they don't duplicate them if reopened)
	for child in get_children():
		child.queue_free()
	#2. Show the Updated index
	for data in npcsData:
		show_npcs(data.name,data.texture)
	

func show_npcs(_name: String,texture: Texture2D):
	#Die Buttons (Lehrer Karten) erstellen
	var my_button = Button.new()
	if SaveManager.get_value("Lehrer", _name, false) == true:
		my_button.set_button_icon(texture)
	else:
		my_button.set_button_icon(preload("res://Dateien/LehrerKarten/unerkannte-Karte.png"))
	
	my_button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	my_button.size_flags_vertical = Control.SIZE_EXPAND_FILL 
	
	
	add_child(my_button)
	
