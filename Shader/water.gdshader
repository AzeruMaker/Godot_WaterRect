shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform vec4 tint : source_color = vec4(1.0); // Default values go after the hint.

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 color = texture(screen_texture, SCREEN_UV, 0.0);
	color = mix(color, tint, 0.4);
	color = mix(vec4(0.5),color,1.4);
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
