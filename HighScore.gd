extends Control

var dir = "res://save/HighScore/"

func ButtonPress():
	var node = get_tree().get_root().get_node("ButtonPressed")
	node.play()

func _on_Button_pressed():
	ButtonPress()
	get_tree().change_scene("res://Menu.tscn")

func LoadScore(level, path = dir):
	var file = File.new()
	path += str(level) + ".txt"
	file.open(path, File.READ)
	file.seek(file.get_position())
	var value = file.get_as_text()
	file.close()
	return value

func _ready():
	for i in range(1, 7):
		var value = LoadScore(i)
		if i < 4:
			var node = get_node("ScoreContainer1/" + str(i))
			node.text = value
			if value == "":
				node.text = "__:__:__"
		else:
			var node = get_node("ScoreContainer2/" + str(i))
			node.text = value
			if value == "":
				node.text = "__:__:__"
