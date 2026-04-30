extends Node

# "user://" is the persistent data directory that persists across game updates
const SAVE_PATH = "user://playerprefs.cfg"
var config = ConfigFile.new()

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
