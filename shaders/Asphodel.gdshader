shader_type spatial;
render_mode cull_disabled;

//uniform float fog_val = 0.001;
uniform sampler2D color_ramp : hint_default_black;
uniform vec3 wind_direction; // Use a negative y component to give it an extra touch (For displacement effect and noise scroll direction)
uniform float wind_strength: hint_range(0.0, 1.0, 0.01) = 0.3;
uniform sampler2D wind_noise; // Periln FBM Noise looks Best
uniform float wind_noise_size: hint_range(0.0, 1.0, 0.001) = 0.05; // high values dont work well
uniform float wind_noise_speed: hint_range(0.0, 1.0, 0.001) = 0.1;

// Instance the Player Position through a GDScript in the _physics_process
instance uniform vec3 player_position;

void vertex() {
	vec3 world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;

	vec3 wind_texture = texture(wind_noise, world_position.xz * wind_noise_size + normalize(-wind_direction.xz) * (TIME + UV.y / 2.5) * wind_noise_speed).rgb;
	vec3 wind_vector = (vec4(wind_texture * normalize(wind_direction) * wind_strength, 0.0) * MODEL_MATRIX).xyz;

	float player_height = smoothstep(1.0, 0.0, length(player_position.y - world_position.y + 0.3));
	vec3 push_direction = vec3(world_position - player_position) * vec3(1 , -0.3 ,1);

	//vec3 player_push_vector = (vec4(normalize(push_direction), 0.0) * MODEL_MATRIX).xyz;

	// Apply Player Position displacement
	//VERTEX += player_push_vector * (1.0 - UV.y) * player_position_factor * player_displacement_strength * player_height;
	// Apply Wind displacement linearly
	VERTEX += wind_vector * (UV.y) * (1.0 * 0.7);

	// A new normal correction, which aligns the normals of the mesh facing upwards no matter the original direction.
	NORMAL = vec3(0.0, 1.0, 0.0);
}

void fragment() {
	ALBEDO = texture(color_ramp, vec2(UV.y, 0)).rgb ;
    //FOG = -FOG*fog_val;
}