#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif


varying vec4 vertColor;
uniform vec3 camPos;
uniform float time;
uniform float near;


uniform float W;
uniform float H;
uniform sampler2D texture;


float distanceToPlane (vec3 point, vec3 planePoint, vec3 planeNormal) {
  vec3 diff = point - planePoint;
  return dot (planeNormal, diff);
}


bool collideWithPlane (vec3 point0, vec3 point1, vec3 planePoint, vec3 planeNormal) {
  float d0 = distanceToPlane(point0, planePoint, planeNormal);
  float d1 = distanceToPlane(point1, planePoint, planeNormal);

  return (sign(d0) != sign(d1));
}


vec3 intersectWithPlane (vec3 start, vec3 dir, vec3 planePoint, vec3 PlaneNormal) {
	float s = (planePoint.z - start.z) / dir.z;
	return camPos + s*dir;
}


float BLOCKSIZE;

void main() {


	vec3 cam = camPos+vec3(W/2.0, H/2.0, 0.0);
	vec3 point = vec3(gl_FragCoord.x, gl_FragCoord.y, near);
	vec3 dir = normalize (point-cam);
	BLOCKSIZE = floor(3.0*(6.0+4.0*sin(time+point.x*0.006)*sin(time*1.2+point.y*0.002))) + sin(time); //sin(time*(0.1+sin(time*0.1)))*24.0;
	
	
	vec2 texCoord = vec2 (floor(gl_FragCoord.x/BLOCKSIZE)*BLOCKSIZE, floor(gl_FragCoord.y/BLOCKSIZE)*BLOCKSIZE) / vec2(W, H);
	texCoord = vec2 (texCoord.x, 1.0 - texCoord.y);
	vec2 ind = vec2 (mod(gl_FragCoord.x, BLOCKSIZE), mod(gl_FragCoord.y, BLOCKSIZE));


	vec3 col = texture2D(texture, texCoord).xyz;
	col = col / 3.0 *BLOCKSIZE*BLOCKSIZE;
	float i = mod ((ind.x + ind.y*BLOCKSIZE) + floor(time*19.0 * sin(0.1*floor(point.x/BLOCKSIZE)))*BLOCKSIZE, BLOCKSIZE*BLOCKSIZE);


	if (i<col.x) {
		col = vec3(1.0, 0.0, 0.0);
	}
	else if (i<col.x+col.y) {
		col = vec3(0.0, 1.0, 0.0);
	}
	else if (i<col.x+col.y+col.z){
		col = vec3(0.0, 0.0, 1.0);
	}
	else {
		col = vec3(0,0,0);
	}

	gl_FragColor = vec4 (col, 1.0);
}
