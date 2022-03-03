extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 40
const MAXFALLSPEED = 600
const MAXSPEED = 80
const JUMPFORCE = 700
const ACCEL = 20

var motion = Vector2()
var facing_right = true

func _ready():
	pass

func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAXSPEED:
		motion.y = MAXSPEED
		
	if facing_right == true:
		$Sprite.scale.x = 1
	else:
			$Sprite.scale.x = -1
	
	motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
	
	if Input.is_action_pressed("right"):
		motion.x += ACCEL
		facing_right = true
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("left"):
		motion.x -= ACCEL
		facing_right = false
		$AnimationPlayer.play("Run")
	else:
		motion.x = lerp(motion.x, 0, 0.2)
		$AnimationPlayer.play("Idle")
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMPFORCE
	
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
		elif motion.y > 0:
			$AnimationPlayer.play("Fall")
	
	motion = move_and_slide(motion, UP)
