extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

const  maxhlt = 100
const speed = 100
const atkrate = 1
const atkdmg = 10
var atkrange = 5
var ishurt = false

var hlt= maxhlt
var isdead = false

var atktimer = 0.0
var player :CharacterBody2D = null
var direc := "right"


func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	print("found" , player)
	
	
	
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	if isdead or player ==null:
		return
	var distance = global_position.distance_to(player.global_position)
	if distance <= atkrange :
		atck(delta)
	else:
		followplayer(delta)
		
		
		
		
		
		
func getdirection(vector :Vector2) -> String:
	if abs(vector.x)> abs(vector.y):
		return "right" if vector.x > 0 else "left"
	else:
		return "down" if vector.y > 0 else "up"
		


func followplayer(delta) -> void:
	var dir = (player.global_position- global_position).normalized()
	velocity = velocity.lerp(dir*speed , 0.1)
	move_and_slide()
	
	direc = getdirection(velocity
	)
	if not ishurt :
		animated_sprite_2d.play("run" + direc)
		
	
	
func atck(delta) -> void:
	velocity= Vector2.ZERO
	var toplayer = player.global_position - global_position
	direc  = getdirection(toplayer
	)
	
	atktimer -= delta
	if atktimer <= 0.0:
		atktimer=atkrate
		doingattack()
		
		
		
		
		
func doingattack()->void:
	if isdead or ishurt :
		return
	animated_sprite_2d.play("attack" + direc)
	await animated_sprite_2d.animation_finished
	if player and global_position.distance_to(player.global_position)<= atkrange:
		player.damage(atkdmg)
		
		

func damage(amt)-> void :
	if isdead or ishurt :
		return
	
	hlt = hlt -amt
	hlt = clamp(hlt,0,maxhlt)
	
	if hlt <= 0 :
		die()
		return
		
	animated_sprite_2d.play(
		"hurt" + direc
	)
	await animated_sprite_2d.animation_finished
	ishurt = false
	
	
func die()-> void:
	isdead= true
	velocity= Vector2.ZERO
	set_physics_process(false
	)
	animated_sprite_2d.play("dead"+direc
	)
	await animated_sprite_2d.animation_finished
	queue_free()	
