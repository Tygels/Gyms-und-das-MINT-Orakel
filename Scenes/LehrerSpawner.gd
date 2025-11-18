extends Node

var lehrerSzene: PackedScene = preload("res://Scenes/Lehrer - NPC.tscn")

func _ready() -> void:
	var npcData = [
		{"id": 1, "position": Vector2(100,100)},
		{"id": 2, "position": Vector2(400,100)},
		{"id": 3, "position": Vector2(200,400)},
	]
	for data in npcData:
		spawn_npc(data.id, data.position)

func spawn_npc(id: int, position: Vector2):
	var npc_instance = lehrerSzene.instantiate()

	#Parameter gleichlegen
	npc_instance.id = id
	npc_instance.position = position
	
	add_child(npc_instance)
