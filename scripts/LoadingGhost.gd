extends MeshInstance3D

@export var delta_y = 0.5
@export var ghost_delay = 0.1
@export var float_time = 1
@export var rotate_speed = 1
@export var track_player_speed = 2

var cur_y
var cur_z
var cur_x
var tween

func _ready():
    cur_z = self.position.z
    cur_y = self.position.y
    cur_x = self.position.x
    tween_up()

func _body_entered(body):
    if body == %Player:
        %Player.interactable = true
        self.interactable = true
    pass
    
func _body_exited(body):
    if body == %Player:
        %Player.interactable = false
        self.interactable = false
    pass

func _process(delta):
    var mouse_pos = get_viewport().get_mouse_position()
    
    self.rotation.y = lerpf(deg_to_rad(-25), deg_to_rad(69), mouse_pos.x/1920)    
    pass
    
func tween_up():
    await get_tree().create_timer(ghost_delay).timeout
    var new_y = delta_y + cur_y
    # Spring ghost settings: var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
    # Standard ghost settings: var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
    tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
    tween.tween_property(self, "position", Vector3(cur_x, new_y, cur_z), float_time)
    tween.tween_callback(self.tween_down)    

func tween_down():
    await get_tree().create_timer(ghost_delay).timeout
    tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
    tween.tween_property(self, "position", Vector3(cur_x, cur_y, cur_z), float_time)
    tween.tween_callback(self.tween_up)    
    
