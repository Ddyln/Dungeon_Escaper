extends Control

func ButtonPress():
	var node = get_tree().get_root().get_node("ButtonPressed")
	node.play()
	
func _on_Back_pressed():
	ButtonPress()
	get_tree().change_scene("res://Menu.tscn")

func _on_Level1_pressed():
	ButtonPress()
	get_tree().change_scene("res://Level 1.tscn")


func _on_Level2_pressed():
	ButtonPress()
	get_tree().change_scene("res://Level 2.tscn")


func _on_Level_3_pressed():
	ButtonPress()
	get_tree().change_scene("res://Level 3.tscn")

func _on_Level_4_pressed():
	ButtonPress()
	get_tree().change_scene("res://Level 4.tscn")

func _on_Level_5_pressed():
	ButtonPress()
	get_tree().change_scene("res://Level 5.tscn")

func _on_Level_6_pressed():
	ButtonPress()
	get_tree().change_scene("res://Level 6.tscn")
