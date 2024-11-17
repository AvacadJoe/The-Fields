extends WorldEnvironment

@export var global_center = Vector3(0,0,0)
@export var starting_fog_density = 0.3
@export var ending_fog_density = 3.0
@export var starting_light_energy = 1.0
@export var ending_light_energy = 0.0
@export var fog_width = 100
@export var game_area_radius = 200

@onready var light = $DirectionalLight3D

func _ready():
    self.environment.volumetric_fog_enabled = true
    pass

func _process(delta):
    var player_dist_from_center = (global_center-%Player.global_position).length()   
   
    # Start the fog / darkening effect outside of game_area_radius
    if (player_dist_from_center > game_area_radius):
        var player_dist_from_game_area = clampf((player_dist_from_center-game_area_radius)/fog_width,0, 1.0)
        self.light.light_energy = lerpf(starting_light_energy, ending_light_energy, player_dist_from_game_area)
        self.environment.volumetric_fog_density = lerpf(starting_fog_density, ending_fog_density, player_dist_from_game_area)
    else:
        self.light.light_energy = starting_light_energy
        self.environment.volumetric_fog_density = starting_fog_density

    pass
