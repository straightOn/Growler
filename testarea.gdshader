shader_type canvas_item;

void fragment() {
	// Get the texture coordinates
	vec2 uv = FRAGCOORD.xy / SCREEN_SIZE.xy;

	// Tile the texture
	vec2 tiledUV = uv * vec2(5.0, 5.0); // Change 5.0 to adjust tiling

	// Output the color from the texture
	vec4 color = texture(TEXTURE, tiledUV);
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
