extends Node2D

var speed = 200.0  # speed in pixels/sec
@onready var spieler = $CharacterBody2D
@onready var Interaktion = $CharacterBody2D/Interaktion
signal interacted(teacher_id)

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
	Interaktion.visible = true

func _on_interaktion_exit_button_pressed() -> void:
	Interaktion.visible = false
