extends Control

func ButtonPress():
	var node = get_tree().get_root().get_node("ButtonPressed")
	node.play()
	
func _on_ChooseLevel_pressed():
	ButtonPress()
	queue_free()
	var node = get_tree().get_root().get_node("Bgm")
	node.playing = true
	get_tree().change_scene("res://ChoosingLevel.tscn")


func _on_ReturnToMainMenu_pressed():
	ButtonPress()
	queue_free()
	var node = get_tree().get_root().get_node("Bgm")
	node.playing = true
	get_tree().change_scene("res://Menu.tscn")

func _ready():
	var node = get_tree().get_root().get_node("InGame")
	node.playing = false
