shader_type spatial;
// Unshaded screen-space post-process effect
// Disable fog for clean fullscreen overlay
render_mode unshaded, fog_disabled;

// Screen resolution for pixelation grid
global uniform vec2 resolution;
// Number of color levels per channel
global uniform float color_depth;

// Screen texture sampled with nearest filtering
uniform sampler2D screen_texture: hint_screen_texture, filter_nearest;
// Blend factor for dither pattern strength
uniform float dither_amount : hint_range(0.0, 1.0, 0.01) = 0.5;

uniform bool dither_lines = true;

// 4x4 Bayer matrix for ordered dithering
// Scaled and centered around zero
const mat4 bayer_matrix = (1.0 / 16.0) * mat4(
 vec4(0.0, 8.0, 2.0, 10.0),
 vec4(12.0, 4.0, 14.0, 6.0),
 vec4(3.0, 11.0, 1.0, 9.0),
 vec4(15.0, 7.0, 13.0, 9.0)
) - 0.5;

// Change render_priority of objects
// you want unaffected by this shader.

void vertex() {
	// Fullscreen quad from screen-space vertex
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	// Snap UV to resolution-sized blocks
	vec2 uv = floor(SCREEN_UV * resolution) / resolution;
	// Integer pixel index for dither pattern
	ivec2 int_uv = ivec2(uv * resolution);

	// Sample screen color at pixelated UV
	vec3 color = texture(screen_texture, uv).rgb;
	// Apply Bayer dither offset using pixel X index
	int dither_col = int_uv.x % 4;
	int dither_row = dither_lines ? int_uv.x  % 4 : int_uv.y % 4;
	
	vec3 dither_color = color + bayer_matrix[dither_col][dither_row] / color_depth * dither_amount;

	// Quantize color to limited depth levels
	vec3 quantized_color = round(dither_color * color_depth) / color_depth;

	// Output final posterized color
	ALBEDO = quantized_color;
}