<script lang="ts">
	import { T, useTask } from '@threlte/core';
	import { useTexture } from '@threlte/extras';
	import { DoubleSide, LinearSRGBColorSpace, Mesh, SRGBColorSpace } from 'three';
	// import * as dat from 'dat.gui';

	import frag from './frag.glsl';
	import vert from './vert.glsl';
	import type { GUI } from 'dat.gui';
	import { onMount } from 'svelte';

	const uniforms = {
		uNoiseScale: {
			value: 13.0,
			type: 'float'
		},
		uTime: {
			value: 0,
			type: 'float'
		},
		uTexture1: {
			value: null,
			type: 'sampler2D'
		},
		uTexture2: {
			value: null,
			type: 'sampler2D'
		}
	};

	let size = { v: 1 };

	useTask((delta) => {
		uniforms.uTime.value += delta;
	});

	const img1 = useTexture('/moon.jpg');
	const img2 = useTexture('/smurf.jpg');

	let plane: Mesh;
	onMount(() => {
		let gui: GUI;
		img1.then((_img1) => {
			// @ts-ignore
			uniforms.uTexture1.value = _img1;
		});

		img2.then((_img2) => {
			// @ts-ignore
			uniforms.uTexture2.value = _img2;
		});

		import('dat.gui').then((dat) => {
			gui = new dat.GUI();
			gui.add(uniforms.uNoiseScale, 'value', 0, 100);
			gui.add(size, 'v', 0, 2).onChange((x) => {
				console.log(x);
				plane.scale.set(x, x, x);
			});
		});

		return () => {
			gui.destroy();
		};
	});
</script>

<T.Mesh bind:ref={plane} rotation.x={Math.PI / 2} position.y={1}>
	<T.PlaneGeometry args={[10, 10, 256, 256]} />
	<T.RawShaderMaterial
		transparent
		side={DoubleSide}
		vertexShader={vert}
		fragmentShader={frag}
		{uniforms}
	/>
</T.Mesh>
