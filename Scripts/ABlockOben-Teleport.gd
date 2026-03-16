extends Node

@onready var SceneTransimissionAnimation = $SceneTransimissionAnimation/AnimationPlayer

func _ready() -> void:
	$SceneTransimissionAnimation.visible = true
	SceneTransimissionAnimation.play("Fade_out")
	$SceneTransimissionAnimation.visible = false



func _on_area_2d_body_entered(_body) -> void:
	if _body.name == "Spieler":
		$SceneTransimissionAnimation.visible = true
		SceneTransimissionAnimation.play("Fade_in")
		await  get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
		$SceneTransimissionAnimation.visible = false
