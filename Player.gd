extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_FALL_SPEED = 200
const MAX_SPEED = 80
const JUMP_FORCE = 300
var FACING_RIGHT = true
var motion = Vector2()
var RESOLUCAO_MAXIMA_Y = 600

func _ready():
	$Camera2D.limit_bottom = RESOLUCAO_MAXIMA_Y

func _physics_process(_delta):
	
	motion.y += GRAVITY
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
	
	if FACING_RIGHT:
		FACING_RIGHT = true
		$"Adventurer-Sheet".scale.x = abs($"Adventurer-Sheet".scale.x)
	elif not FACING_RIGHT:
		FACING_RIGHT = false
		$"Adventurer-Sheet".scale.x = -abs($"Adventurer-Sheet".scale.x)
		
	
	motion.x = clamp(motion.x,-MAX_SPEED,MAX_SPEED)
	
	if Input.is_action_pressed("right"):
		motion.x = MAX_SPEED
		FACING_RIGHT = true
		$AnimationPlayer.play("run")
	
	elif Input.is_action_pressed("left"):
		motion.x = -MAX_SPEED
		FACING_RIGHT = false
		$AnimationPlayer.play("run")
	
	else: 
		motion.x = lerp(motion.x,0,0.2)
		$AnimationPlayer.play("idle")
	
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			motion.y = -JUMP_FORCE
	if !is_on_floor():
		if motion.y < 0:
			$AnimationPlayer.play("Jump")
		elif motion.y > 0:
			$AnimationPlayer.play("fall")
	
	motion = move_and_slide(motion,UP)
