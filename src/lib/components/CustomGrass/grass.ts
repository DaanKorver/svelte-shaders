import {
	BufferAttribute,
	BufferGeometry,
	DoubleSide,
	Float32BufferAttribute,
	InstancedBufferAttribute,
	InstancedBufferGeometry,
	Mesh,
	MeshBasicMaterial,
	RawShaderMaterial,
	SphereGeometry
} from 'three';

import vert from './grass.vert';
import frag from './grass.frag';

export function createGrass({ uniforms }: { uniforms: any }): Mesh {
	const geometry = new InstancedBufferGeometry();
	// const geometry = new BufferGeometry();

	const verts = [];
	verts.push(0.5, -0.5, 0);
	verts.push(-0.5, -0.5, 0);
	verts.push(-0.5, 0.5, 0);
	verts.push(0.5, 0.5, 0);

	const indices = [0, 1, 2, 2, 3, 0];

	const uvs = [1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0];

	const instances = 150000;

	const w = 35;
	const z = 35;

	const terrainPos = [0.0, 0.0, 0.0];
	const angles = [];
	const heights = [];
	for (let i = 0; i < instances; i++) {
		const posiX = Math.random() * w - w / 2;
		const posiY = 0;
		const posiZ = Math.random() * z - z / 2;

		terrainPos.push(posiX, posiY, posiZ);

		const angle = Math.random() * 360;
		angles.push(angle);

		const height = Math.min(Math.random() + 0.3, 1);
		heights.push(height);
	}

	geometry.setIndex(indices);
	geometry.setAttribute('position', new Float32BufferAttribute(verts, 3));
	geometry.setAttribute('uv', new Float32BufferAttribute(uvs, 2));

	geometry.setAttribute(
		'terrainPos',
		new InstancedBufferAttribute(new Float32Array(terrainPos), 3)
	);
	geometry.setAttribute('angle', new InstancedBufferAttribute(new Float32Array(angles), 1));
	geometry.setAttribute('height', new InstancedBufferAttribute(new Float32Array(heights), 1));
	geometry.instanceCount = instances;

	const material = new RawShaderMaterial({
		vertexShader: vert,
		fragmentShader: frag,
		side: DoubleSide,
		wireframe: false,
		uniforms
	});
	const mesh = new Mesh(geometry, material);
	mesh.frustumCulled = false;

	return mesh;
}
