precision mediump float;

varying vec2 vUv;
varying float vNoise;

uniform float uNoiseScale;
uniform float uTime;

vec3 blue1 = vec3(0.059, 0.369, 0.612);
vec3 blue2 = vec3(0.11, 0.639, 0.925);

vec3 green1 = vec3(0.075, 0.427, 0.082);
vec3 green2 = vec3(0.149, 0.545, 0.027);

vec3 brown1 = vec3(0.353, 0.224, 0.106);
vec3 brown2 = vec3(0.318, 0.235, 0.141);

float map(float value, float min1, float max1, float min2, float max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

vec3 getCol(vec3 color1, vec3 color2, float v, float minValue, float maxValue) {
  float a = map(v, minValue, maxValue, 0.0, 1.0);
  return mix(color1, color2, a);
}

void main() {
  vec3 color;

  if(vNoise < 0.4) {
    color = getCol(blue1, blue2, vNoise, 0.0, 0.4);
  } else if(vNoise < 0.7) {
    color = getCol(green1, green2, vNoise, 0.4, 0.7);
  } else if(vNoise < 0.75) {
    color = getCol(brown1, brown2, vNoise, 0.7, 0.75);
  } else {
    color = vec3(1);
  }

  gl_FragColor = vec4(color, 1.0);
}
