extends Node

var lehrerSzene: PackedScene = preload("res://Scenes/Lehrer - NPC.tscn")
var npc_list: Array = []


func _ready() -> void:
	var npcData = [
		{"id": 1, "position": Vector2(300,250), "portrait": "res://test data/Dr._Wagener_Icon-default-removebg-preview.png"},
		{"id": 2, "position": Vector2(935,-280), "portrait": "res://test data/TeacherTest.png"},
	]
	for data in npcData:
		spawn_npc(data.id, data.position, data.portrait)

func spawn_npc(id: int, position: Vector2, portrait: String):
	var npc = lehrerSzene.instantiate()

	#Parameter gleichlegen
	npc.teacher_id = id
	npc.position = position
	npc.portrait = portrait
	
	add_child(npc)
	
	npc_list.append(npc)
	
	var spieler = get_tree().current_scene.get_node("Spieler")
	npc.interacted.connect(spieler._on_lehrer_interacted)
