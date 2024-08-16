extends CharacterBody2D

var chase = false
const SPEED = 100.0
var alive = true

@onready var animation = $AnimatedSprite2D

func _physics_process(delta) -> void:
	if alive == true:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta
			
		var player = $"../Player"
		var direction = (player.position - self.position).normalized()
		if chase == true:
			velocity.x = direction.x * SPEED
			animation.play("idle")
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
		move_and_slide()

func _on_detector_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		chase = true


func _on_death_body_entered(body: Node2D) -> void:
	alive == false
	if body.name == "Player":
		body.coins += 5
		queue_free()


func _on_damage_body_entered(body: Node2D) -> void:
	if alive == true:
		if body.name == "Player":
			body.health -= 40
