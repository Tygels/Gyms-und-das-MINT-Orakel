extends Node

var lehrerSzene: PackedScene = preload("res://Scenes/Lehrer - NPC.tscn")
var npc_list: Array = []


func _ready() -> void:
	var npcData = [
		{"id": 3, "position": Vector2(-320,-280), "portrait": "res://test data/testTeacher.png"},
		{"id": 7, "position": Vector2(-320,-280), "portrait": "res://Dateien/Feldmann.png"},
		{"id": 8, "position": Vector2(-320,-280), "portrait":"res://Dateien/Heim.png" },
		{"id": 9, "position": Vector2(-320,-280), "portrait": "res://Dateien/Matoussi.png"},
		{"id": 10, "position": Vector2(-320,-280), "portrait": "res://Dateien/Schmieding.png"},
		{"id": 11, "position": Vector2(-320,-280), "portrait": "res://Dateien/Steinhoff.png"},
		{"id": 12, "position": Vector2(-320,-280), "portrait": "res://Dateien/Wutke.png"},
		{"id": 13, "position": Vector2(-320,-280), "portrait": "res://Dateien/Gropper.png"}
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
