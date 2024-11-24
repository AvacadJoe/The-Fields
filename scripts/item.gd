extends MeshInstance3D

@export  var item : GameManager.Items = GameManager.Items.DEFAULT
@onready var interact_area = $InteractArea
@onready var interact_gizmo = $InteractIcon

var interactable = false :
    set (value):
        interact_gizmo.visible = value            
        interactable = value
    get:
        return interactable

func _ready():
    interact_area.body_entered.connect(_body_entered)
    interact_area.body_exited.connect(_body_exited)
    %Player.interact.connect(_interact)    
    pass
    

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
        if item == GameManager.Items.FLASHLIGHT:
            GameManager.flashlight_unlocked = true
            %Player.interactable = false
            self.queue_free()
    pass
