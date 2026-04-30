extends Node2D
@onready var array = get_node_or_null("../../../LehrerSpawner")


func _ready() -> void:
	$ScrollContainer.visible = false
	visible = true



func _on_button_button_up() -> void: #Open Pokedex
	$ScrollContainer.visible = true
	$OpenButton.visible = false 
	if array:
		for Lehrer in array.npc_list:
			Lehrer.hide()
			Lehrer.is_active = false
			Lehrer.can_move = false

func _on_close_button_button_up() -> void: #Close Pokedex
	$ScrollContainer.visible = false
	$OpenButton.visible = true
	if array:
		for Lehrer in array.npc_list:
			Lehrer.show()
			Lehrer.is_active = true
			Lehrer.can_move = true


func _on_spieler_interact() -> void: #Open Teacher Interaction
	$OpenButton.visible = false 


func _on_interaktion_exit_button_pressed() -> void: # Close Teacher 
	$OpenButton.visible = true
