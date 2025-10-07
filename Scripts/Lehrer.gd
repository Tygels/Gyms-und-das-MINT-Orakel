extends Node2D

@onready var Lehrer = $Area2D
@onready var Spieler = get_tree().current_scene.get_node("Spieler")
@export var teacher_id: String = ""
var data = null
signal interacted(teacher_id)

func _ready():
	$InteractHint.visible = false
	Lehrer.body_entered.connect(_on_Area2D_body_entered)
	Lehrer.body_exited.connect(_on_Area2D_body_exited)


func set_data(d: Dictionary) -> void:
	data = d
	if data.has("portdrait"):
		$Portrait.texture = load(data["portrait"]) if ResourceLoader.exists(data["portrait"]) else null


func _on_Area2D_body_entered(_body):
	$InteractHint.visible = true


func _on_Area2D_body_exited(_body):
	$InteractHint.visible = false

func _process(_delta):
	if Input.is_action_pressed("Lehrer_UI_open") and $InteractHint.visible == true:
		emit_signal("interacted", teacher_id)
		$InteractHint.visible = false
