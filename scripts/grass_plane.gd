extends MeshInstance3D

@onready var grass_node = %GrassMultiMesh

func _ready():
    %Player.player_position_change.connect(_player_position_change)
    pass

func _player_position_change(player_position):
    grass_node.set_deferred("instance_shader_parameters/player_position", Vector3(player_position.x, -0.1, player_position.z))
    pass
