extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 150
var grid = []
var goal = []
var crate = []
var n = 0
var finish = 0
var paused = []
var dir = "res://save/HighScore/"

func LoadScore(path):
	var file = File.new()
	file.open("path", File.READ)
	file.seek(file.get_position())
	var value = file.get_as_text()
	file.close()
	return value

func Compare(s, t):
	if t == "":
		return s
		
	var n = 8
	# hh:mm:ss
	# 01234567
	
	var x = int(s[0]) * 10 + s[1]
	var y = int(t[0]) * 10 + t[1]
	if x > y:
		return s
	if y > x:
		return t
	
	x = int(s[3]) * 10 + s[4]
	y = int(t[3]) * 10 + t[4]
	if x > y:
		return s
	if y > x:
		return t
		
	x = int(s[6]) * 10 + s[7]
	y = int(t[6]) * 10 + t[7]
	if x > y:
		return s
	return t
	
func SaveScore():
	var s = get_parent().name
	var level = s[s.length() - 1]
	var path = dir + level + ".txt"
	
	var node = get_parent().get_node("TimeCounter")
	s = node.s
	var h = node.h
	var m = node.m
	var newResult = ("%02d:%02d:%02d" % [h, m, s])
	
	var oldResult = LoadScore(path)
	if Compare(newResult, oldResult) == newResult:
		var file = File.new()
		file.open(path, File.WRITE)
		file.store_string(newResult)
		file.close()

func _process(delta):
	if paused[0]:
		return
	
	velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("pause"):
		paused[0] = true
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
		var node = load("res://PauseMenu.tscn").instance()
		get_tree().current_scene.add_child(node)
		return
	
	finish = 1
	for i in range(n):
		var x = goal[i][0]
		var y = goal[i][1]
		if grid[x][y] == false:
			finish = 0
	if finish:
		paused[0] = true
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
		SaveScore()
		var node = load("res://FinishLevel.tscn").instance()
		get_tree().current_scene.add_child(node)
		var SoundEffect = load("res://FinishLevelSE.tscn").instance()
		get_tree().current_scene.add_child(SoundEffect)
		return
	
	speed = 150
	$AnimatedSprite.speed_scale = 1
	if Input.is_action_pressed("run"):
		speed = 300
		$AnimatedSprite.speed_scale = 2
	
	if Input.is_action_pressed("crouch"):
		speed = 75
		$AnimatedSprite.speed_scale = 0.5
		
	if Input.is_action_pressed("ui_left"):
		velocity = Vector2.LEFT
		$AnimatedSprite.play("left")
		
	if Input.is_action_pressed("ui_right"):
		velocity = Vector2.RIGHT
		$AnimatedSprite.play("right")
		
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP
		$AnimatedSprite.play("up")
		
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2.DOWN
		$AnimatedSprite.play("down")
	
	if Input.is_action_just_released("ui_left") or \
		Input.is_action_just_released("ui_right") or \
		Input.is_action_just_released("ui_up") or \
		Input.is_action_just_released("ui_down"):
		$AnimatedSprite.stop()
		$AnimatedSprite.frame = 0
	
	for i in range(n):
		if crate[i].pushing == false:
			var x = crate[i].transform[2][0] / 64
			var y = crate[i].transform[2][1] / 64
			grid[x][y] = true
			
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		var node = collision.collider
		if node is KinematicBody2D:
			var x = node.transform[2][0] / 64
			var y = node.transform[2][1] / 64
			grid[x][y] = false

			node.push(velocity)
			
func _ready():
	paused.append(false)
	for i in range(20):
		grid.append([])
		for _j in range(20):
			grid[i].append(false)
			
	while true:
		var target = "goal" + char(49 + n)
		var node = get_parent().get_node(target)
		if node == null:
			break
		goal.append([])
		goal[n].append(node.transform[2][0] / 64)
		goal[n].append(node.transform[2][1] / 64)
		
		target = "crate" + char(49 + n)
		crate.append(get_parent().get_node(target))
		n += 1
	
	var node = get_tree().get_root().get_node("Bgm")
	node.playing = false
	node = get_tree().get_root().get_node("InGame")
	node.playing = true
