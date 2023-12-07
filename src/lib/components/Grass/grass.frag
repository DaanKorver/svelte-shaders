precision mediump float;

varying vec2 vUv;
varying float vHeight;

uniform float uGridSize;
uniform float uThickness;
uniform float uAttenuation;
varying vec3 vNormal;

float hash12(vec2 p) {
	vec3 p3  = fract(vec3(p.xyx) * .1031);
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.x + p3.y) * p3.z);
}

void main () {
  // Making the grid for each individual grass piece
  vec2 uv = vUv;
  vec2 gridCoords = floor(uv * uGridSize);
  vec2 cellUV = fract(uv * uGridSize);

  // Local UV per grass piece
  vec2 localUV = fract(cellUV) * 2. -1.;
  float localDistanceFromCenter = length(localUV);


  // Generating a random hash
  float hash = hash12(gridCoords);

  // Color based on the hash and the height of the quad
  float grass = 1.0 - step(hash, vHeight);
  vec3 color = vec3(0.439,0.753,0.282);

  // Simple ambient occlusion
  float ambientOcclusion = pow(vHeight, uAttenuation);

  // Trying to add Lambertian diffuse, work in progress
  vec3 lightPosition = vec3(0.,10.,10.);
  float diffuse = 2.;
  float ld = dot(normalize(vNormal),normalize(lightPosition)) * diffuse ;

  // Color multiply for lighting
  color *= ambientOcclusion;
  color *= ld;

  // Thickness per piece of grass
  float thick = step(localDistanceFromCenter, uThickness * (hash - vHeight));

  // Deciding which pixels to show and which are transparent, also, thickness :)
  vec4 final = vec4(color, grass * thick);

  gl_FragColor = final;
}