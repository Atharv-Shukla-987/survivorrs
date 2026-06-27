extends Node


const spwanminrad = 200.0


const spawnmaxrad = 600.0

const wavedelay = 8.0

@export var enemyscene :PackedScene
@export var enemynode: PackedScene

var cur_wave := 0
var enemyalive := 0
var wavaactive:= false
var player: CharacterBody2D = null

signal wavestart()
signal waveend()


func _ready() -> void:
	add_to_group("wave_manager")
	player = get_tree().get_first_node_in_group("player")
	await get_tree().create_timer(.5).timeout
	nextwave()
 

func nextwave()-> void:
	cur_wave += 1
	var enemycount = cur_wave * 5
	enemyalive = enemycount
	wavaactive = true
	
	emit_signal("wavestart",cur_wave)
	
	for i in enemycount:
		spawn()
	
	
	
	
		
func spawn()-> void:
	if enemyscene == null or player == null :
		return
	var enemy = enemyscene.instantiate()
	var angle = randf()* TAU
	var distance = randf_range(spwanminrad,spawnmaxrad)
	var offset = Vector2(cos(angle),sin(angle)) * distance
	enemy.global_position = player.global_position + offset
	enemy.died.connect(_on_enemy_died)
	get_tree().current_scene.add_child(enemy)
	
func _on_enemy_died() -> void:
	enemyalive -= 1
	if enemyalive <=0:
		wavaactive = false
		emit_signal("waveend" , cur_wave)
		await get_tree().create_timer(wavedelay).timeout
		nextwave()
