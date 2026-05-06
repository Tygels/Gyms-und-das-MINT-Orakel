extends Node2D

@onready var SceneTransimissionAnimation = $SceneTransimissionAnimation/AnimationPlayer

func _ready() -> void:
	$SceneTransimissionAnimation.visible = true
	SceneTransimissionAnimation.play("Fade_out")
	$SceneTransimissionAnimation.visible = false

func _on_tür_unten_body_entered(body: Node2D) -> void:
	print("elfksdjfkjsdf")
	if body.name == "Spieler":
		$"SceneTransimissionAnimation".visible = true
		SceneTransimissionAnimation.play("Fade_in")
		await  get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/Game.tscn")
		$"SceneTransimissionAnimation".visible = false


func _on_tür_rechts_body_entered(body: Node2D) -> void:
	if body.name == "Spieler":
		$"SceneTransimissionAnimation".visible = true
		SceneTransimissionAnimation.play("Fade_in")
		await  get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/A-223-Raum.tscn")
		$"SceneTransimissionAnimation".visible = false


func _on_tür_oben_body_entered(body: Node2D) -> void:
	if body.name == "Spieler":
		$"SceneTransimissionAnimation".visible = true
		SceneTransimissionAnimation.play("Fade_in")
		await  get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/A-232-Raum.tscn")
		$"SceneTransimissionAnimation".visible = false
