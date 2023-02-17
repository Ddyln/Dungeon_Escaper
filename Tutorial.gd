extends Control

func _on_Back_pressed():
	var node = get_tree().get_root().get_node("ButtonPressed")
	node.play()
	get_tree().change_scene("res://Menu.tscn")
