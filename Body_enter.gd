extends CollisionShape2D


func on_CollisionShape2D_body_enter(body):
	if body.name == "Spieler":
		get_tree().change_scene("res://Interaktion.tscn")
