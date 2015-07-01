#define PROCESSING_COLOR_SHADER

#define PI 3.1417
uniform mat4 transform;
uniform mat4 texMatrix;

attribute vec4 vertex;
attribute vec4 color;
attribute vec4 normal;
attribute vec2 texCoord;



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

mat4 rotationMatrix(vec3 axis, float angle)
{
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;
    
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
  

  vec4 pos = vertex;
  vec2 target = normal.xy * w;
  
  int i = int(normal.x);
  int j = int(normal.z);

  float tx = ramp(time, 0.0, 0.3);
  float tz = ramp(time, 4.0, 0.3);



  float dx = blend (0.0, target.x, tx);
  float dy = sin(time + normal.x)*1000.0;
  float dz = blend (0.0, target.y, tz);





  // calculate translation and scale matrix
  vec3 translate = vec3(sin(time)*1000.0, 0.0, 0.0);
  mat4 matrix = mat4 (1.0, 0.0, 0.0, translate.x,
  					  0.0, 1.0, 0.0, translate.y,
  					  0.0, 0.0, 1.0, translate.z,
   					  0.0, 0.0, 0.0, 1.0);

  // rotate around x
  mat4 Rx = rotationMatrix (vec3(1,0,0), sin(time + dx*0.001 + dz*0.001)*PI);
  mat4 Rz = rotationMatrix (vec3(0,0,1), sin(time + normal.z*0.0)*PI);


  // ROTATE
  pos = pos * Rx;
  //pos = pos * Rz;


  // TRANSLATE
  pos.x += dx;
  pos.z += dz;



  gl_Position = transform * pos;
}