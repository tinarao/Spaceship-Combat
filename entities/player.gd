extends CharacterBody2D

const SPEED = 15.0
const JUMP_VELOCITY = -400.0
var dir = "right"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	$AnimatedSprite2D.play("idle")
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	control_mov()
	control_shoot()

	move_and_slide()

func control_shoot():
	if Input.is_action_just_pressed("shoot"):
		print("Shoot")

func control_mov():
	if Input.is_action_pressed("left"):
		dir = "left"
		play_anim("run")
		velocity.x -= SPEED
	elif Input.is_action_pressed("right"):
		dir = "right"
		play_anim("run")
		velocity.x += SPEED
	else:
		velocity.x = 0
		play_anim("idle")

func play_anim(type: String):
	if dir == "left":
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
		
	$AnimatedSprite2D.play(type)
