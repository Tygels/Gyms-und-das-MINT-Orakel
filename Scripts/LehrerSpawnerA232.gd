extends Node

var lehrerSzene: PackedScene = preload("res://Scenes/Lehrer - NPC.tscn")
var npc_list: Array = []


func _ready() -> void:
	var npcData = [
		{"id": 11, "position": Vector2(-320,-280), "portrait": "res://Dateien/Steinhoff.png"},
		{"id": 12, "position": Vector2(0,-60), "portrait": "res://Dateien/Wutke.png"},
		{"id": 13, "position": Vector2(-60,100), "portrait": "res://Dateien/Gropper.png"},
		{"id": 14, "position": Vector2(200,-270), "portrait": "res://Dateien/Langerklein.png"}
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
