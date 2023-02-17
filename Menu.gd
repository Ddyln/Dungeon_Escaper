extends Control

func ButtonPress():
	var node = get_tree().get_root().get_node("ButtonPressed")
	node.play()

func _on_Choose_level_pressed():
	ButtonPress()
	get_tree().change_scene("res://ChoosingLevel.tscn")

func _on_High_Score_pressed():
	ButtonPress()
	get_tree().change_scene("res://HighScore.tscn")

func _on_Tutorial_pressed():
	ButtonPress()
	get_tree().change_scene("res://Tutorial.tscn")
	
func _on_Setting_pressed():
	ButtonPress()
	get_tree().change_scene("res://Setting.tscn")

func _on_Quit_pressed():
	get_tree().quit()

func _ready():
	var id = AudioServer.get_bus_index("Master")
	var file = File.new()
	file.open("res://save/volume.txt", File.READ)
	file.seek(file.get_position())
	var value = file.get_as_text()
	file.close()
	AudioServer.set_bus_volume_db(id, float(value))
	OS.center_window()
