extends KinematicBody2D

var pushing = false
var x = self.transform[2][0] / 64
var y = self.transform[2][1] / 64
onready var tween = get_parent().get_node("pushing")
onready var player = get_parent().get_node("player")

func push(direction):
	if pushing:
		return
		
	if test_move(transform, direction * 64):
		return
		
	pushing = true
	player.grid[x][y] = false
	tween.interpolate_property(
		self, "position",
		position, position + 64 * direction,
		0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	tween.start()

func _on_Tween_tween_all_completed():
	pushing = false
