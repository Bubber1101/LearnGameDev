extends Sprite2D

var speed = 2
var angular_speed = PI
var health = 10

signal health_zero
signal health_changed(old_value, new_value)

func take_damage(amount):
	var old_health = health
	health -= amount
	health_changed.emit(old_health, health)
	if health <= 0:
		health = 0
		health_zero.emit()

func _init():
	print("Hello world!")

func _ready():
	randomize()
	var timer = get_node("og_timer")
	timer.timeout.connect(_on_timer_timeout)
	health_changed.connect(_on_health_changed)
	health_zero.connect(_on_health_zero)
	
func _on_health_changed(old_health, health):
	print("DAMAGE: " + str(health - old_health))
	
func _on_health_zero():
	print("GAME OVER :CCC")
	reset()
	health = 10

func _on_timer_timeout():
	if(speed != 0):
		take_damage(randi() % 5) 

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
		reset()

func reset():
		speed = 0
		position = DisplayServer.window_get_size() / 2

func _on_button_pressed():
	set_process(not is_processing())
	

