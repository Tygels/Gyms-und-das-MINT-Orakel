extends Node2D

var speed = 200.0  # speed in pixels/sec
@onready var spieler = $CharacterBody2D
@onready var Interaktion = $CharacterBody2D/Interaktion
@onready var Interaktion2 = $CharacterBody2D/Interaktion2
@onready var exitbutton2 = $CharacterBody2D/Interaktion2/MainButtons/ExitButton
var current_teacher = null
@onready var spawner = $"../LehrerSpawner"



func _ready():
	Interaktion.exit_button_pressed.connect(_on_Interaktion_exit_button_pressed)
	Interaktion2.exit_button_pressed.connect(_on_Interaktion2_exit_button_pressed)


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


func _on_lehrer_interacted() -> void:
	interaction()

#initialisiert die Interation
func interaction() -> void: 
	Interaktion.visible = true
	
func _on_lehrer_2_interacted_2() -> void:
	Interaktion2.visible = true


func _on_Interaktion_exit_button_pressed() -> void:
	Interaktion.visible = false
	
	
func _on_Interaktion2_exit_button_pressed() -> void:
	Interaktion2.visible = false
