uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;

uniform float uTime;

attribute vec3 position;
attribute vec2 uv;

varying vec2 vUv;
varying float vHeight;

void main() {

  // Normalizing the uv
  // vec2 nUv = uv * 2.0 - 1.0;
  vec3 nPosition = position;
   // Set up the basic parameters
  float amplitude = .1;
  float speed = 1.0;

      // Define frequencies for each wave
  float frequency1 = 3.0;
  float frequency2 = 8.0;
  float frequency3 = 5.0;

    // Create waves based on sine functions
  float wave1 = amplitude * sin(uv.y * frequency1 * 3.1415 + uTime * speed);
  float wave2 = amplitude * sin(uv.x * frequency2 * 3.1415 + uTime * speed);
  float wave3 = amplitude * sin((uv.x + uv.y) * frequency3 * 3.1415 + uTime * speed);

 // Combine the waves
  float waterHeight = wave1 + wave2 + wave3;

  nPosition.z += waterHeight;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(nPosition, 1.0);
  vUv = uv;
  vHeight = waterHeight;
}