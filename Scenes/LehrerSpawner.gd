extends Node

var lehrerSzene: PackedScene = preload("res://Scenes/Lehrer - NPC.tscn")
var npc_list: Array = []


func _ready() -> void:
	var npcData = [
		{"id": 1, "position": Vector2(240,-330), "portrait": "res://Dateien/Klinkhammer.png"},
		{"id": 2, "position": Vector2(-260,-270), "portrait": "res://Dateien/Bachhausen2.png"},
		{"id": 4, "position": Vector2(0,0), "portrait": "res://Dateien/Achenbach.png"},
		{"id": 5, "position": Vector2(0,0), "portrait": "res://Dateien/Bloem.png"},
		{"id": 6, "position": Vector2(0,0), "portrait":"res://Dateien/Christogeoros.png" },
		
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
