extends Control

var master_bus = AudioServer.get_bus_index("Master")
var dir = "res://save/volume.txt"

func _on_Back_pressed():
	var node = get_tree().get_root().get_node("ButtonPressed")
	node.play()
	get_tree().change_scene("res://Menu.tscn")

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)
	AudioServer.set_bus_mute(master_bus, value == -30)
	SaveVolume(str(value))

func _ready():
	var value = LoadVolume()
	$HSlider.value = int(value)

func SaveVolume(value, path = dir):
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(value)
	file.close()

func LoadVolume(path = dir):
	var file = File.new()
	file.open(path, File.READ)
	file.seek(file.get_position())
	var value = file.get_as_text()
	file.close()
	return value
