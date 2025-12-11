extends Node2D

@onready var InteractHint = $InteractHint
@onready var Lehrer = $Area2D
var teacher_id
var portrait
signal interacted(teacher_id)
var is_active := true



func _ready():
	InteractHint.visible = false
	Lehrer.body_entered.connect(_on_Area2D_body_entered)
	Lehrer.body_exited.connect(_on_Area2D_body_exited)
	if portrait != null:
		$Portrait.texture = load(portrait)



func _on_Area2D_body_entered(_body):
	if _body.name == "CharacterBody2D":
		InteractHint.visible = true


func _on_Area2D_body_exited(_body):
	InteractHint.visible = false

func _process(_delta):
	if Input.is_action_pressed("Lehrer_UI_open") and InteractHint.visible == true:
		emit_signal("interacted", teacher_id)
		hide()              # NPC disappears
		is_active = false
