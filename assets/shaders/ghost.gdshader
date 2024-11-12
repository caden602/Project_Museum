shader_type canvas_item;

uniform vec4 lightColor = vec4(0.5, 0.8, 1.0, 1.0); // light blue color
uniform float transparency = 0.5; // adjust transparency
uniform float glowIntensity = 1.5; // adjust glow intensity

void fragment() {
    // Calculate glow
    vec4 glow = lightColor * glowIntensity;
    
    // Combine lighting and glow
    vec4 finalColor = lightColor + glow;
    
    // Apply transparency
    finalColor.a = transparency;
    
    // Output final color
    COLOR = finalColor;
}