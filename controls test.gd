extends BoxContainer  

func _ready() -> void:
    $BoxContainer/Button2Menu.visible = false

func _on_Button2_pressed():
     $BoxContainer/Button2Menu.visible = !$BoxContainer/Button2Menu.visible
