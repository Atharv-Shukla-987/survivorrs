extends CharacterBody2D

const maxhlt = 1
const firingrate = 1  
@onready var pivit: Node2D = $pivit

@onready var gun: AnimatedSprite2D = $pivit/gun
@onready var muzzle: Marker2D = $pivit/gun/muzzle

@export var bulletscene : PackedScene

var speed=150 
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var isattacking: bool = false
var ishurt :bool = false

var hlt = maxhlt
var firingtimmer = 0.0
  


func _physics_process(delta: float) -> void:
	var direc = Vector2.ZERO 
	direc.x = Input.get_axis("left" , "right")
	
	direc.y = Input.get_axis("up","down")
	
	if direc != Vector2.ZERO :
		direc = direc.normalized()
		
		
	velocity = speed * direc
	move_and_slide()
	
	
	animation(direc)
	flip(direc)
	gunaim()
	firing(delta)
	

	
func animation(direc:Vector2) -> void :
	if isattacking or ishurt :
		return
	if direc == Vector2.ZERO :
		animated_sprite_2d.play("idle")
	else:
		animated_sprite_2d.play("running")
		
		
		
		
func gunaim()-> void:
	var mouseposition = get_global_mouse_position()
	pivit.look_at(mouseposition)
	
	if cos(pivit.rotation) > 0 :
		gun.flip_v = true
	else :
		gun.flip_v =false
		
	
	
# for sprite flippp

func flip(direc : Vector2)-> void:
	if direc.x > 0 :
		animated_sprite_2d.flip_h = false
		
		
	elif direc.x < 0 :
		animated_sprite_2d.flip_h = true
	
		
func damage(amt) -> void:
	print("yes")
	if ishurt == true :
		return
		
	hlt -= amt
	if hlt <= 0 :
		dead()
		
	animated_sprite_2d.play("damage")
	await animated_sprite_2d.animation_finished
	
	
func dead()-> void:
	animated_sprite_2d.play("death")
	gun.visible = false
	set_physics_process(false)
	await get_tree().create_timer(0.43).timeout
	queue_free()
	
	


func firing(delta) -> void :
	firingtimmer -= delta
	if firingtimmer <= 0.0:
		firingtimmer = firingrate
		shoot()
		
	

	
func shoot( ) -> void :
	print("hh")
	if bulletscene == null :
		return
	var bullet = bulletscene.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = muzzle.global_position
	bullet.direction = (get_global_mouse_position() - muzzle.global_position).normalized()
	
	
	 
