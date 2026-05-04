extends Node

# "user://" is the persistent data directory that persists across game updates
const SAVE_PATH = "user://playerprefs.cfg"
var config = ConfigFile.new()
var session_id: String = "h"

func _ready() -> void:
	load_data()

# Mimicking PlayerPrefs.Set*
func set_value(section: String, key: String, value: Variant) -> void:
	config.set_value(section, key, value)
	
# Mimicking PlayerPrefs.Get*
func get_value(section: String, key: String, default: Variant = null) -> Variant:
	return config.get_value(section, key, default)

# Gets all keys in a section (useful for your UI)
func get_all_keys_in_section(section: String) -> PackedStringArray:
	if config.has_section(section):
		return config.get_section_keys(section)
	return PackedStringArray()

func save_data() -> void:
	config.save(SAVE_PATH)

func load_data() -> void:
	var err = config.load(SAVE_PATH)
	if err != OK:
		print("No save file found or failed to load. Starting fresh.")

# Save automatically when the game window is closed
func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_data()

func reset_defaults() -> void:
	config.clear()
	

func create_new_session():
	# 1. Zeitstempel im lesbaren Format (JJJJ-MM-TT_HH-MM-SS)
	var datetime = Time.get_datetime_dict_from_system()
	var timestamp = "%04d%02d%02d_%02d%02d%02d" % [
		datetime.year, datetime.month, datetime.day,
		datetime.hour, datetime.minute, datetime.second
	]
	
	# 2. Ein zufälliger Suffix, falls zwei Leute exakt zur gleichen Sekunde starten
	var random_suffix = str(randi() % 10000).pad_zeros(4)
	
	# 3. Zusammensetzen der ID
	session_id = ("SESSION_" + timestamp + "_" + random_suffix)
	
	print("Neue Sitzung generiert: ", session_id)

func clear_session():
	session_id = ""
