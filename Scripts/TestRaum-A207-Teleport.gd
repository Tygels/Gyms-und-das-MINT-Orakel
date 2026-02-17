extends Node

@onready var SceneTransimissionAnimation = $SceneTransimissionAnimation/AnimationPlayer

func _ready() -> void:
	$SceneTransimissionAnimation.visible = true
	SceneTransimissionAnimation.play("Fade_out")
	$SceneTransimissionAnimation.visible = false
func _on_node_2d_entered() -> void:
	$SceneTransimissionAnimation.visible = true
	SceneTransimissionAnimation.play("Fade_in")
	await  get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/A207-Raum.tscn")
	$SceneTransimissionAnimation.visible = false
