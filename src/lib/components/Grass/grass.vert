uniform float uShellSpacing;
uniform float uTime;

varying vec2 vUv;
varying vec3 vNormal;
varying float vHeight;

void main() {
  // Calculate the position of the current instance
  float instanceIndex = float(gl_InstanceID);
  vec3 pos = position;
  pos.z += instanceIndex * uShellSpacing;

  // Setting the position of the instance
  vec4 final = projectionMatrix * modelViewMatrix * instanceMatrix * vec4(pos, 1.0);
  gl_Position = final;

  // Calculate vHeight by normalizing it between 0 and 1
  // TODO: 64 is currently a magic number but should represent the amount of planes
  vHeight = float(gl_InstanceID) / 64.;

  // Varryings
  vUv = uv;
  vNormal = normal;
}