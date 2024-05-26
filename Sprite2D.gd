extends Sprite2D

var speed = 2
var angular_speed = PI


func _init():
	print("Hello world!")

func _process(delta):
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	if Input.is_action_pressed("ui_up"):
		speed += 0.3
	if Input.is_action_pressed("ui_down"):
		speed = 0 if speed <= 0 else speed - 0.5

		
		
	rotation += angular_speed * direction * delta
	
	position += Vector2.UP.rotated(rotation+0.85+PI) * speed
	
	if Input.is_key_pressed(KEY_R):
		speed = 0
		position = DisplayServer.window_get_size() / 2
