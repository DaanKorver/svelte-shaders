uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat4 instanceMatrix;
uniform float uTime;

attribute vec3 position;
attribute vec2 uv;
attribute vec3 terrainPos;
attribute float angle;

varying vec2 vUv;

vec4 quat_from_axis_angle(vec3 axis, float angle) {
  vec4 qr;
  float half_angle = (angle * 0.5) * 3.14159 / 180.0;
  qr.x = axis.x * sin(half_angle);
  qr.y = axis.y * sin(half_angle);
  qr.z = axis.z * sin(half_angle);
  qr.w = cos(half_angle);
  return qr;
}

vec3 rotate_vertex_position(vec3 position, vec3 axis, float angle) {

  vec4 q = quat_from_axis_angle(axis, angle);
  vec3 v = position.xyz;
  return v + 2.0 * cross(q.xyz, cross(q.xyz, v) + q.w * v);

}

void main() {
  vec3 pos = position;

  pos.x *= 0.15;
  pos.y += .5;

  pos += terrainPos;

  if(pos.y > .5) {
    pos.x += sin(uTime * (angle * 0.01)) * 0.025;
    pos.z += cos(uTime * (angle * 0.01)) * 0.025;
  }

  vec3 axis = vec3(0., 1., 0.);
  vec3 finalPos = rotate_vertex_position(pos, axis, angle);

  vec4 final = projectionMatrix * modelViewMatrix * vec4(finalPos, 1.0);
  gl_Position = final;
  vUv = uv;
}