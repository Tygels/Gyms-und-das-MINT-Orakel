extends Node

@onready var SceneTransimissionAnimation = $SceneTransimissionAnimation/AnimationPlayer

func _ready() -> void:
	$SceneTransimissionAnimation.visible = true
	SceneTransimissionAnimation.play("Fade_out")
	$SceneTransimissionAnimation.visible = false

func _teleport_A_207_Raum(body) -> void:
	if body.name == "Spieler":
		$"SceneTransimissionAnimation".visible = true
		SceneTransimissionAnimation.play("Fade_in")
		await  get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/A207-Raum.tscn")
		$"SceneTransimissionAnimation".visible = false


func _Teleport_A_205(body) -> void:
	if body.name == "Spieler":
		$"SceneTransimissionAnimation".visible = true
		SceneTransimissionAnimation.play("Fade_in")
		await  get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/A-205-Raum.tscn")
		$"SceneTransimissionAnimation".visible = false


func _Teleport_A_223(_body) -> void:
	if _body.name == "Spieler":
		$"SceneTransimissionAnimation".visible = true
		SceneTransimissionAnimation.play("Fade_in")
		await  get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/A-223-Raum.tscn")
		$"SceneTransimissionAnimation".visible = false


func _Teleport_A_232(body) -> void:
	if body.name == "Spieler":
		$"SceneTransimissionAnimation".visible = true
		SceneTransimissionAnimation.play("Fade_in")
		await  get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://Scenes/A-232-Raum.tscn")
		$"SceneTransimissionAnimation".visible = false
