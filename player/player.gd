extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const GRAVITY = 900
const SPEED = 96;
const JUMP_FORCE = 300;

var velocity = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if not is_on_floor(): velocity.y += GRAVITY * delta;
	else: velocity.y = 0;
	velocity.x = 0;
	
	if Input.is_action_pressed("left"):
		velocity.x -= SPEED;
		$AnimatedSprite.flip_h = true;
	
	if Input.is_action_pressed("right"):
		velocity.x += SPEED;
		$AnimatedSprite.flip_h = false;
	
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = -JUMP_FORCE;
	
	velocity = move_and_slide(velocity, Vector2.UP);
