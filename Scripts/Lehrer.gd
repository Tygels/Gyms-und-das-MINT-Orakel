extends Node2D

@onready var Spieler = $Spieler
@export var teacher_id: String = ""
var data = null
signal interacted(teacher_id)

func _ready():
	$InteractHint.visible = false
	$Area2D.body_entered.connect(_on_Area2D_body_entered)
	$Area2D.body_exited.connect(_on_Area2D_body_exited)


func set_data(d: Dictionary) -> void:
	data = d
	if data.has("portdrait"):
		$Portrait.texture = load(data["portrait"]) if ResourceLoader.exists(data["portrait"]) else null


func _on_Area2D_body_entered(body):
	if body.name == "Spieler":
		$InteractHint.visible = true


func _on_Area2D_body_exited(body):
	if body.name == "Spieler":
		$InteractHint.visible = false


func _input(event):
# When player presses E while in range, emit interacted
	if event.is_action_pressed("ui_accept") and $InteractHint.visible:
		emit_signal("interacted", teacher_id)
