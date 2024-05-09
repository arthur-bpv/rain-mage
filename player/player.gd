extends CharacterBody2D

var ice_projectile = preload("res://player/projectiles/ice/projectile.tscn");
var grass_projectile = preload("res://player/projectiles/grass/projectile.tscn");
var crystal_projectile = preload("res://player/projectiles/crystal/projectile.tscn");
var life = preload("res://player/Life.tscn")

const SPEED = 96;
const GRAVITY = 900;
const JUMP_FORCE = 300;


var select = "ThunderShield";
var magic = false;

var dash_cooldown = 0;
var dash = false;

var damage = -1

func _is_jump(): return not is_on_floor() and velocity.y < 0;
func _is_fall(): return not is_on_floor() and velocity.y > 0;

func _move():
	if Input.is_action_pressed("left"):
		velocity.x -= SPEED;
		$AnimatedSprite2D.scale.x = -1;
	
	if Input.is_action_pressed("right"):
		velocity.x += SPEED;
		$AnimatedSprite2D.scale.x = 1;

func _jump():
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = -JUMP_FORCE;

func _dash():
	if Input.is_action_just_pressed("dash") and dash_cooldown <= 0:
		dash = true;
		$AnimatedSprite2D.play("dash")
		dash_cooldown = 1.5;

func _magic():
	if Input.is_action_just_pressed("magic") and is_on_floor():
		magic = true;
		$AnimatedSprite2D.play(select);
	
		if $AnimatedSprite2D.animation == "IceShot":
			for n in 3:
				await get_tree().create_timer(0.2 * n).timeout;
				var p = ice_projectile.instantiate();
				p.global_transform = $AnimatedSprite2D/Marker2D.global_transform;
				get_tree().root.get_child(0).add_sibling(p);
	
		if $AnimatedSprite2D.animation == "GrassRadial":
			for n in 9:
				var a = 22.5 * n
				var p = grass_projectile.instantiate();
				p.global_position = global_position;
				p.global_rotation_degrees = a + 180;
				get_tree().root.get_child(0).add_sibling(p);
	
		if $AnimatedSprite2D.animation == "CrystalShot":
			await $AnimatedSprite2D.animation_finished;
			var p = crystal_projectile.instantiate();
			p.global_transform = $AnimatedSprite2D/Marker2D.global_transform;
			get_tree().root.get_child(0).add_sibling(p);

func _anim():
	if magic or dash: return
	if _is_jump(): $AnimatedSprite2D.play("jump"); return
	if _is_fall(): $AnimatedSprite2D.play("fall"); return;
	
	if velocity.x == 0: $AnimatedSprite2D.play("idle"); return;
	if velocity.x == SPEED or velocity.x == -SPEED: $AnimatedSprite2D.play("walk"); return;

func _process(delta):
	dash_cooldown -= delta;
	$AnimatedSprite2D/Marker2D.look_at(get_global_mouse_position());
	
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
		
		if select == "ThunderShield" and $AnimatedSprite2D.frame >= 2 and Input.is_action_pressed("magic"):
			$AnimatedSprite2D.frame = 2;
	
	if dash:
		velocity.x += SPEED * 2.6 * $AnimatedSprite2D.scale.x
	
	_anim();
	set_velocity(velocity)
	set_up_direction(Vector2.UP)
	set_floor_stop_on_slope_enabled(true)
	move_and_slide();


func _on_AnimatedSprite_animation_finished():
	var name = $AnimatedSprite2D.animation;
	
	if name == "dash":
		dash = false;
	
	if name == "ThunderShield" or name == "BloodHeal" or name == "GrassRadial" or name == "IceShot" or name == "CrystalShot":
		magic = false;

#func _life():
#	if life + damage:

#não terminei porque fui para a escola
