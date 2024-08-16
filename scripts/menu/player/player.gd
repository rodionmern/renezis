extends CharacterBody2D

const SPEED = 75.0
const JUMP_VELOCITY = -400.0

var health = 100
var coins = 0

@onready var animation = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if Input.is_action_pressed("ui_right"):
			$AnimatedSprite2D.flip_h = false
		if Input.is_action_pressed("ui_left"):
			$AnimatedSprite2D.flip_h = true
		$".".animation.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$".".animation.play("idle")
		
	if health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://scenes/game_menu.tscn")
		
	move_and_slide()
