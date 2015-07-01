#define PROCESSING_COLOR_SHADER
#define PI 3.1417

uniform mat4 transform;
uniform mat4 texMatrix;

attribute vec4 vertex;
attribute vec4 color;
attribute vec4 normal;
attribute vec2 texCoord;

varying vec3 col;

// f[+f]f[-f]f
// f[+f]f[-f]f

float S = 7.0;

uniform float time;
uniform float w;



float blend (float x0, float x1, float t) {
	return x0*(1.0-t) - x1*t;
}



float ramp (float t, float start, float speed) {
	float ret = (t-start)*speed;
	if (ret<0.0) ret = 0.0;
	if (ret>1.0) ret = 1.0;

	return ret;
}

mat4 rotationMatrix(vec3 axis, float angle) {
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;
    
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}


vec4 translate (vec4 pos, float x, float y, float z) {
  return pos + vec4(x,y,z,0);
}

vec4 translate (vec4 pos, vec3 theTranslate) {
  return pos + vec4(theTranslate,0);
}


vec4 rotate (vec4 pos, vec3 axis, float angle) {
  mat4 m = rotationMatrix (axis, angle);
  return pos * m;
}


void main() {
  

  vec4 pos = vertex;
  float ind = normal.x;



  //pos = rotate(pos, vec3(0,0,1), a2);

  float x = mod (ind,50.0);
  float z = floor(ind/50.0);


  pos = rotate(pos, vec3(1,0,0), ind*0.01+time*z*0.2);
  pos = rotate(pos, vec3(0,0,1), ind*0.02+time*x*0.2);

  pos = translate(pos, x*550.0, 0.0, -z*550.0);

  gl_Position = transform * pos;
  col = vec3(x,x,x);
}




