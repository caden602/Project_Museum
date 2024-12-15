shader_type spatial;

// Scale of deformation
uniform float height_scale = 0.5;
// Noise texture, OpenSimplexNoise works very well
uniform sampler2D noise;
// The transparency of the entire ghost (set to 0.0 to hide it completely)
uniform float alpha : hint_range(0, 1) = 1.0;
// Emission light color
uniform vec4 color : source_color = vec4(0.0, 1.0, 1.0, 1.0);

float fresnel(float amount, vec3 normal, vec3 view)
{
	return pow((1.0 - clamp(dot(normalize(normal), normalize(view)), 0.0, 1.0 )), amount);
}

void vertex() {
	// Deform the vertices using the noise texture
	vec2 tex_position = VERTEX.xy / 2.0 + 0.5 + 0.3 * TIME;
	float height = texture(noise, tex_position).x;
	VERTEX = VERTEX * (1.0 + height * height_scale);
}