precision mediump float;

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform float uNoiseScale;
uniform float uTime;

attribute vec3 position;
attribute vec2 uv;

varying vec2 vUv;
varying float vNoise;

vec2 fade(vec2 t) {
  return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

vec4 permute(vec4 x) {
  return mod(((x * 34.0) + 1.0) * x, 289.0);
}

float cnoise(vec2 P) {
  vec4 Pi = floor(P.xyxy) + vec4(0.0, 0.0, 1.0, 1.0);
  vec4 Pf = fract(P.xyxy) - vec4(0.0, 0.0, 1.0, 1.0);
  Pi = mod(Pi, 289.0); // To avoid truncation effects in permutation
  vec4 ix = Pi.xzxz;
  vec4 iy = Pi.yyww;
  vec4 fx = Pf.xzxz;
  vec4 fy = Pf.yyww;
  vec4 i = permute(permute(ix) + iy);
  vec4 gx = 2.0 * fract(i * 0.0243902439) - 1.0; // 1/41 = 0.024...
  vec4 gy = abs(gx) - 0.5;
  vec4 tx = floor(gx + 0.5);
  gx = gx - tx;
  vec2 g00 = vec2(gx.x, gy.x);
  vec2 g10 = vec2(gx.y, gy.y);
  vec2 g01 = vec2(gx.z, gy.z);
  vec2 g11 = vec2(gx.w, gy.w);
  vec4 norm = 1.79284291400159 - 0.85373472095314 *
    vec4(dot(g00, g00), dot(g01, g01), dot(g10, g10), dot(g11, g11));
  g00 *= norm.x;
  g01 *= norm.y;
  g10 *= norm.z;
  g11 *= norm.w;
  float n00 = dot(g00, vec2(fx.x, fy.x));
  float n10 = dot(g10, vec2(fx.y, fy.y));
  float n01 = dot(g01, vec2(fx.z, fy.z));
  float n11 = dot(g11, vec2(fx.w, fy.w));
  vec2 fade_xy = fade(Pf.xy);
  vec2 n_x = mix(vec2(n00, n01), vec2(n10, n11), fade_xy.x);
  float n_xy = mix(n_x.x, n_x.y, fade_xy.y);
  return 2.3 * n_xy;
}

//

vec3 hash3(vec2 p) {
  vec3 q = vec3(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)), dot(p, vec2(419.2, 371.9)));
  return fract(sin(q) * 43758.5453);
}

float iqnoise(in vec2 x, float u, float v) {
  vec2 p = floor(x);
  vec2 f = fract(x);

  float k = 1.0 + 63.0 * pow(1.0 - v, 4.0);

  float va = 0.0;
  float wt = 0.0;
  for(int j = -2; j <= 2; j++) for(int i = -2; i <= 2; i++) {
      vec2 g = vec2(float(i), float(j));
      vec3 o = hash3(p + g) * vec3(u, u, 1.0);
      vec2 r = g - f + o.xy;
      float d = dot(r, r);
      float ww = pow(1.0 - smoothstep(0.0, 1.414, sqrt(d)), k);
      va += o.z * ww;
      wt += ww;
    }

  return va / wt;
}

#define OCTAVES 6
float fbm(in vec2 st) {
    // Initial values
  float value = 0.0;
  float amplitude = .5;
  float frequency = 0.;
    //
    // Loop of octaves
  for(int i = 0; i < OCTAVES; i++) {
    value += amplitude * iqnoise(st, 1., 0.8);
    st *= 2.;
    amplitude *= .5;
  }
  return value;
}

vec2 mirrored(vec2 v) {
  vec2 m = mod(v, 2.);
  return mix(m, 2.0 - m, step(1.0, m));
}

void main() {
  // vec2 nUv = uv * 2. - 1.;
  vec2 nUv = uv;

  // float x = sign(nUv.x);
  // float y = sign(nUv.y);

  // nUv = fract(nUv);
  // nUv = mirrored(nUv);

  // nUv.x -= (uTime * 0.2) * x;
  // nUv.y -= (uTime * 0.2) * y;

  float noise = fbm(nUv * uNoiseScale);
  vec3 nPos = position;
  // nPos.z += noise;

  gl_Position = projectionMatrix * modelViewMatrix * vec4(nPos, 1.0);

  vUv = nUv;
  vNoise = noise;
}
