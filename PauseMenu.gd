extends Control

func _on_Quit_pressed():
	get_tree().quit()
	
func ButtonPress():
	var node = get_tree().get_root().get_node("ButtonPressed")
	node.play()

func _on_Resume_pressed():
	ButtonPress()
	get_parent().get_node("player").paused[0] = false
	queue_free()


func _on_Return_to_Main_Menu_pressed():
	var node = get_tree().get_root().get_node("InGame")
	node.playing = false
	get_tree().get_root().get_node("Bgm").play()
	ButtonPress()
	queue_free()
	get_tree().change_scene("res://Menu.tscn")


func _on_Choose_Level_pressed():
	var node = get_tree().get_root().get_node("InGame")
	node.playing = false
	get_tree().get_root().get_node("Bgm").play()
	ButtonPress()
	queue_free()
	get_tree().change_scene("res://ChoosingLevel.tscn")
