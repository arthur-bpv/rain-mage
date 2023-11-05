extends KinematicBody2D

var ice_projectile = preload("res://player/projectiles/ice/projectile.tscn");
var grass_projectile = preload("res://player/projectiles/grass/projectile.tscn");
var crystal_projectile = preload("res://player/projectiles/crystal/projectile.tscn");

const SPEED = 96;
const GRAVITY = 900;
const JUMP_FORCE = 300;

var velocity = Vector2.ZERO;

var select = "ThunderShield";
var magic = false;

var dash_cooldown = 0;
var dash = false;

func _is_jump():
	return not is_on_floor() and velocity.y < 0;

func _is_fall():
	return not is_on_floor() and velocity.y > 0;

func _move():
	if Input.is_action_pressed("left"):
		velocity.x -= SPEED;
		$AnimatedSprite.scale.x = -1;
	
	if Input.is_action_pressed("right"):
		velocity.x += SPEED;
		$AnimatedSprite.scale.x = 1;

func _jump():
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = -JUMP_FORCE;

func _dash():
	if Input.is_action_just_pressed("dash") and dash_cooldown <= 0:
		dash = true;
		$AnimatedSprite.play("dash")
		dash_cooldown = 1.5;

func _magic():
	if Input.is_action_just_pressed("magic") and is_on_floor():
		magic = true;
		$AnimatedSprite.play(select);
	
		if $AnimatedSprite.animation == "IceShot":
			for n in 3:
				yield(get_tree().create_timer(0.2 * n), "timeout");
				var p = ice_projectile.instance();
				p.global_transform = $AnimatedSprite/Position2D.global_transform;
				get_tree().root.get_child(0).add_child(p);
	
		if $AnimatedSprite.animation == "GrassRadial":
			for n in 8:
				var a = 25.5 * n
				var p = grass_projectile.instance();
				p.global_position = global_position;
				p.global_rotation_degrees = a + 180;
				get_tree().root.get_child(0).add_child(p);
	
		if $AnimatedSprite.animation == "CrystalShot":
			yield($AnimatedSprite, "animation_finished");
			var p = crystal_projectile.instance();
			p.global_transform = $AnimatedSprite/Position2D.global_transform;
			get_tree().root.get_child(0).add_child(p);

func _anim():
	if magic or dash: return
	if _is_jump(): return $AnimatedSprite.play("jump");
	if _is_fall(): return $AnimatedSprite.play("fall");
	
	if velocity.x == 0: return $AnimatedSprite.play("idle");
	if velocity.x == SPEED or velocity.x == -SPEED: return $AnimatedSprite.play("walk")

func _process(delta):
	dash_cooldown -= delta;
	$AnimatedSprite/Position2D.look_at(get_global_mouse_position());
	
	if not is_on_floor() and not dash: velocity.y += GRAVITY * delta;
	else: velocity.y = 0;
	velocity.x = 0;
	
	if not magic and not dash:
		_move();
		_jump();
		_dash();
		_magic();
	
	if magic:
		if select == "CrystalShot":
			_move();
		
		if select == "ThunderShield" and $AnimatedSprite.frame >= 2 and Input.is_action_pressed("magic"):
			$AnimatedSprite.frame = 2;
	
	if dash:
		velocity.x += SPEED * 2.6 * $AnimatedSprite.scale.x
	
	_anim();
	move_and_slide(velocity, Vector2.UP, true);


func _on_AnimatedSprite_animation_finished():
	var name = $AnimatedSprite.animation;
	
	if name == "dash":
		dash = false;
	
	if name == "ThunderShield" or name == "BloodHeal" or name == "GrassRadial" or name == "IceShot" or name == "CrystalShot":
		magic = false;
