extends Node2D


var speed = 400.0  # speed in pixels/sec
@onready var spieler = $Spieler
@onready var Interaktion = $Spieler/Interaktion
signal interacted(teacher_id)
signal interact
@export var current_teacher = null
@export var Teacher_id = null
@onready var spawner = $"../LehrerSpawner"
var LehrerConfig = ConfigFile.new()
@onready var Pop_Up_Sprite = $"Spieler/Pop-Up"
@onready var Pokedex = $Spieler/Pokedex/ScrollContainer

# Assuming your AnimatedSprite2D is a child of this node
@onready var animated_sprite = $Spieler/AnimatedSprite2D 

# We store the last direction so we know which way to face when standing still
var letzte_richtung = "unten" 

func _ready() -> void:
	connect("interacted", _on_lehrer_interacted)

	LehrerConfig.load("Lehrer")


func _physics_process(_delta):
	var richtung = Vector2.ZERO
	
	# Combine your UI checks into one variable for cleaner reading
	var can_move = (Interaktion.visible == false) and (Pokedex.visible == false)
	
	# Bewegungen
	if can_move:
		if Input.is_action_pressed("Bewegung_oben"):
			richtung.y -= 1
		if Input.is_action_pressed("Bewegung_unten"):
			richtung.y += 1
		if Input.is_action_pressed("Bewegung_rechts"):
			richtung.x += 1 # Fixed from =+
		if Input.is_action_pressed("Bewegung_links"):
			richtung.x -= 1 # Fixed from =-
	
	# Normieren damit diagonale bewegungen nicht schneller sind
	if richtung != Vector2.ZERO:
		richtung = richtung.normalized()
		_update_animations(richtung)
	else:
		_play_idle_animation()

	spieler.velocity = richtung * speed
	spieler.move_and_slide()

# Custom function to handle moving animations
func _update_animations(dir: Vector2):
	# We check X axis first. If you prefer up/down to override left/right, 
	# just swap the if/elif order.
	if dir.x > 0:
		animated_sprite.play("Rechts_Gehen")
		letzte_richtung = "rechts"
	elif dir.x < 0:
		animated_sprite.play("Links_Gehen")
		letzte_richtung = "links"
	elif dir.y > 0:
		animated_sprite.play("Unten_Gehen")
		letzte_richtung = "unten"
	elif dir.y < 0:
		animated_sprite.play("Oben_Gehen")
		letzte_richtung = "oben"

# Custom function to handle standing still animations
func _play_idle_animation():
	if letzte_richtung == "rechts":
		animated_sprite.play("Rechts_Stehen")
	elif letzte_richtung == "links":
		animated_sprite.play("Links_Stehen")
	elif letzte_richtung == "unten":
		animated_sprite.play("Unten_Stehen")
	elif letzte_richtung == "oben":
		animated_sprite.play("Oben_Stehen")


func _on_lehrer_interacted(teacher_id: Variant) -> void:
	if Interaktion.visible == false:
		for npc in spawner.npc_list:
			if npc.teacher_id == teacher_id:
				current_teacher = npc
				Teacher_id = teacher_id
				break
		emit_signal("interact")
		Interaktion.visible = true
		
	# Save the interaction as "True" (using a boolean is better than a string)
	SaveManager.set_value("Lehrer", str(teacher_id), true)
	# Optional: Save immediately to disk so progress isn't lost on a crash
	SaveManager.save_data()
		
	for npc in spawner.npc_list:
		npc.hide()

func _on_interaktion_exit_button_pressed() -> void:
	Interaktion.visible = false
	
	if current_teacher:
		current_teacher.show()
		current_teacher.is_active = true
		current_teacher = null
		Teacher_id = null
	for npc in spawner.npc_list:
		npc.show()
		npc.resume_movement()
		
	Pop_Up()

func Pop_Up() -> void:
	if SaveManager.get_value("Lehrer", str(Teacher_id)) == true: #Fall = Lehrer ist schon bekannt
		pass
	else: #Fall = Lehrer unbkannt
		Pop_Up_Sprite.visible = true
		await  get_tree().create_timer(0.5).timeout
		Pop_Up_Sprite.visible = false
