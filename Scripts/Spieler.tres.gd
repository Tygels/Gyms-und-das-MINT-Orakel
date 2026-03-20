extends Node2D

var speed = 400.0  # speed in pixels/sec
@onready var spieler = $Spieler
@onready var Interaktion = $Spieler/Interaktion
signal interacted(teacher_id)
signal interact
@export var current_teacher = null
@export var Teacher_id = null
@onready var spawner = $"../LehrerSpawner"

func _ready() -> void:
	connect("interacted", _on_lehrer_interacted)

func _physics_process(_delta):
	var richtung = Vector2.ZERO
	# Bewegungen
	if Input.is_action_pressed("Bewegung_oben") and (Interaktion.visible == false):
		richtung.y -= 1
	if Input.is_action_pressed("Bewegung_unten") and (Interaktion.visible == false):
		richtung.y += 1
	
	if Input.is_action_pressed("Bewegung_rechts") and (Interaktion.visible == false):
		richtung.x =+ 1
	
	if Input.is_action_pressed("Bewegung_links") and (Interaktion.visible == false):
		richtung.x =- 1
	
	# Normieren damit diagonale bewegungen nicht schneller sind
	if richtung != Vector2.ZERO:
		richtung = richtung.normalized()


	spieler.velocity = richtung * speed

	spieler.move_and_slide()


func _on_lehrer_interacted(teacher_id: Variant) -> void:
	if Interaktion.visible == false:
		for npc in spawner.npc_list:
			if npc.teacher_id == teacher_id:
				current_teacher = npc
				Teacher_id = teacher_id
				break
		emit_signal("interact")
		Interaktion.visible = true
		
		for npc in spawner.npc_list:
			npc.hide()

func _on_interaktion_exit_button_pressed() -> void:
	Interaktion.visible = false
	
	if current_teacher:
		current_teacher.show()
		current_teacher.is_active = true
		current_teacher = null
		Teacher_id = null
	for npc in spawner.npc_list:
		npc.show()
		npc.resume_movement()
