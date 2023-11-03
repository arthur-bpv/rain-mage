extends KinematicBody2D

const SPEED = 96;
const GRAVITY = 900;
const JUMP_FORCE = 300;

var velocity = Vector2.ZERO;

var select = "thunder_block";
var magic = false;

func magic():
	magic = true;
	$AnimatedSprite.play(select)

func _is_jump():
	return not is_on_floor() and velocity.y < 0;

func _is_fall():
	return not is_on_floor() and velocity.y > 0;

func _anim():
	if magic: return
	if _is_jump(): return $AnimatedSprite.play("jump");
	if _is_fall(): return $AnimatedSprite.play("fall");
	
	if velocity.x == 0: return $AnimatedSprite.play("idle");
	else: return $AnimatedSprite.play("walk");

func _process(delta):
	velocity.x = 0;
	if not is_on_floor(): velocity.y += GRAVITY * delta;
	else: velocity.y = 0;
	
	if not magic:
		if Input.is_action_pressed("left"):
			velocity.x -= SPEED;
			$AnimatedSprite.flip_h = true;
		
		if Input.is_action_pressed("right"):
			velocity.x += SPEED;
			$AnimatedSprite.flip_h = false;
		
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = -JUMP_FORCE;
		
		if Input.is_action_just_pressed("magic") and is_on_floor():
			magic();
	
	_anim();
	move_and_slide(velocity, Vector2.UP, true);


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "thunder_block": magic = false;
	if $AnimatedSprite.animation == "ice_attack": magic = false;
