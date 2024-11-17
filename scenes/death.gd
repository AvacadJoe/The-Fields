extends MeshInstance3D


@export var rotation_speed = 2.0
@export var interact_rotation_speed = 2.0
@export var death_dialogue_1 : DialogueResource
@export var death_dialogue_2 : DialogueResource
@onready var interact_area = $InteractArea
@onready var interact_gizmo = $InteractIcon

var dialogue_count = 0

var interactable = false :
    set (value):
        interact_gizmo.visible = value            
        interactable = value
    get:
        return interactable
        
func _process(delta):
    _turn_to_player(delta)
    interact_area.body_entered.connect(_body_entered)
    interact_area.body_exited.connect(_body_exited)
    %Player.interact.connect(_interact)    
   
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
    
func _interact():
    if interactable:
        if dialogue_count == 0:
            %DialogueMenu.start(death_dialogue_1.duplicate(), "death_intro")
            dialogue_count = 1
        elif dialogue_count == 1:
            %DialogueMenu.start(death_dialogue_2.duplicate(), "death_loop")
    pass
    
func _turn_to_player(delta):
    var aim_vector = (%Player.position - self.position)
    aim_vector = aim_vector.normalized()
    var aim_vector2d = Vector2(aim_vector.x, -aim_vector.z)
    var angle_to = aim_vector2d.angle()
    if !interactable: #rotate faster if next to death
        self.rotation.y = lerp_angle(self.rotation.y, angle_to, delta*rotation_speed)
    else:
        self.rotation.y = lerp_angle(self.rotation.y, angle_to, delta*interact_rotation_speed)
    pass
