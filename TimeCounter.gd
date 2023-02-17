extends RichTextLabel

var s = 0
var m = 0
var h = 0
onready var timer = get_node("Timer")

func _process(delta):	
	if s > 59:
		s = 0
		m += 1
		
	if m > 59:
		m = 0
		h += 1
		
	set_text(" Time:  %02d:%02d:%02d" % [h, m, s])

func _ready():
	timer.set_wait_time(1)
	timer.start()

func _on_Timer_timeout():
	var paused = get_parent().get_node("player").paused[0]
	if paused == false:
		s += 1
