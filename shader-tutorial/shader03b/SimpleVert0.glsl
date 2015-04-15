#define PROCESSING_TEXTURE_SHADER

uniform mat4 transform;
uniform mat4 texMatrix;

attribute vec4 vertex;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 vertColor;
varying vec4 vertTexCoord;

uniform float total_w;
uniform float total_h;
uniform float timePassed;

uniform sampler2D texture;
float freq = 1.0;
float height = 1.0;

void main() {
    
    vec2 worldTexCoord = vertex.xy / vec2(total_w, total_h);
    
    gl_Position = transform * vertex;
    
    //vertColor = vec4(worldTexCoord,0,1);
    vertColor = texture2D(texture, worldTexCoord);
}