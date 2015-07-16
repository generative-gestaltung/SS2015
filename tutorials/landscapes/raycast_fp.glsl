#version 120 

#define N 15

uniform vec3 [N] cubes;
uniform vec3 cameraPos;
uniform vec2 dim;
uniform float near;


#define NUMDIM	3
#define RIGHT	0
#define LEFT	1
#define MIDDLE	2


vec3 hitPos;
vec3 hitNorm;


vec3 arrayToVec (float[3] arr) {
	return vec3 (arr[0], arr[1], arr[2]);
}

bool HitBoundingBox (float minB[NUMDIM], float maxB[NUMDIM], float origin[NUMDIM], float dir[NUMDIM] ) {
	bool inside = true;
	int quadrant[NUMDIM];
	int i;
	int whichPlane;
	float maxT[NUMDIM];
	float candidatePlane[NUMDIM];
	float coord[NUMDIM];

	// Find candidate planes; this loop can be avoided if
   	// rays cast all from the eye(assume perpsective view)
	for (i=0; i<NUMDIM; i++)
		if(origin[i] < minB[i]) {
			quadrant[i] = LEFT;
			candidatePlane[i] = minB[i];
			inside = false;
		}else if (origin[i] > maxB[i]) {
			quadrant[i] = RIGHT;
			candidatePlane[i] = maxB[i];
			inside = false;
		}else	{
			quadrant[i] = MIDDLE;
		}

	// Ray origin inside bounding box
	if(inside) {
		coord = origin;
		return true;
	}

	// Calculate T distances to candidate planes
	for (i = 0; i < NUMDIM; i++) {
		
		if (quadrant[i] != MIDDLE && dir[i] != 0) {
			maxT[i] = (candidatePlane[i]-origin[i]) / dir[i];
		}
		else {
			maxT[i] = -1.;
		}
	}
	
	// Get largest of the maxT's for final choice of intersection 
	whichPlane = 0;
	for (i = 1; i < NUMDIM; i++) {
		if (maxT[whichPlane] < maxT[i]) {
			whichPlane = i;
		}
	}

	// Check final candidate actually inside box
	if (maxT[whichPlane] < 0.) return false;
	
	for (i = 0; i < NUMDIM; i++) {
		if (whichPlane != i) {
			coord[i] = origin[i] + maxT[whichPlane] *dir[i];
			if (coord[i] < minB[i] || coord[i] > maxB[i])
				return false;
		} else {
			coord[i] = candidatePlane[i];
		}
	}
	
	hitPos = arrayToVec (coord);
	return true;
}	

bool hitBox (vec3 theMinB, vec3 theMaxB, vec3 theOrigin, vec3 theDir) {
	
	float minB[NUMDIM];
	minB[0] = theMinB.x;
	minB[1] = theMinB.y;
	minB[2] = theMinB.z;
	
	
	float maxB[NUMDIM];
	maxB[0] = theMaxB.x;
	maxB[1] = theMaxB.y;
	maxB[2] = theMaxB.z;
	
	
	float origin[NUMDIM];
	origin[0] = theOrigin.x;
	origin[1] = theOrigin.y;
	origin[2] =	theOrigin.z;
	
	
	float dir[NUMDIM];
	dir[0] = theDir.x;
	dir[1] = theDir.y;
	dir[2] = theDir.z;
	
	
	bool hit = HitBoundingBox (minB, maxB, origin, dir);
	return (hit);
}


void main() {

	vec2 p = floor (gl_FragCoord.xy - dim/2);
	vec3 dir = normalize(cameraPos + vec3(p,near));
	vec3 col;

	col = vec3(0);	
	
	
	for (int i=0; i<N; i++) {
		if (hitBox (cubes[i], cubes[i]+vec3(4000,4000,200), cameraPos, dir)) {
			float b = distance (cameraPos, hitPos);
			col = vec3(1.0,1.0,0)*1000.0 / b;
		}
	}
	
	gl_FragData[0] = vec4(col, 1.0);
}