extends CharacterBody2D

@export var moveSpeed = 300
@export var jumpSpeed = -400
@export var acceleration = 15
@export var slowDown = 150

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Pelihahmon liikuttaminen asettamalla sille nopeus-vektori (velocity)
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	elif Input.is_action_just_pressed("jump"):
		velocity.y = jumpSpeed
		
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * moveSpeed, acceleration)
	else:
		velocity.x =  move_toward(velocity.x, 0.0, slowDown)
	
	move_and_slide()
	set_animation(direction)
	
func set_animation(direction : float) -> void:
	if direction > 0:
		$PlayerSprite.flip_h = false
	else:
		$PlayerSprite.flip_h = true
		
	if is_on_floor() and velocity.x != 0:
		$PlayerAnimation.play("walk")
	elif not is_on_floor() and velocity.y < 0:
		$PlayerAnimation.play("jump_air")
	elif not is_on_floor() and velocity.y > 0:
		$PlayerAnimation.play("jump_air")
	else:
		$PlayerAnimation.play("idle")
	
	pass
