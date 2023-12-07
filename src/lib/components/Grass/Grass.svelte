<script lang="ts">
	import { T, useFrame } from '@threlte/core';
	import { DoubleSide } from 'three';

	import { Instance, InstancedMesh } from '@threlte/extras';
	import type { GUI } from 'dat.gui';
	import { onMount } from 'svelte';
	import fragment from './grass.frag';
	import vertex from './grass.vert';

	const shells = Array.from({ length: 64 });

	useFrame(({ clock }) => {
		uniforms.uTime.value = clock.getElapsedTime();
	});

	const uniforms = {
		uGridSize: {
			value: 80
		},
		uShellSpacing: {
			value: 0.007
		},
		uThickness: {
			value: 2
		},
		uAttenuation: {
			value: 1
		},
		uTime: {
			value: 0
		}
	};

	onMount(() => {
		let gui: GUI;

		import('dat.gui').then((dat) => {
			gui = new dat.GUI();
			gui.add(uniforms.uGridSize, 'value', 10, 300).name('Grid size');
			gui.add(uniforms.uShellSpacing, 'value', 0, 0.2, 0.001).name('Shell spacing');
			gui.add(uniforms.uThickness, 'value', 0, 3, 0.01).name('Thickness');
			gui.add(uniforms.uAttenuation, 'value', 0, 2, 0.01).name('Attenuation');
		});

		return () => {
			gui.destroy();
		};
	});
</script>

<InstancedMesh rotation.x={-Math.PI / 2} update>
	<T.PlaneGeometry args={[5, 5]} />
	<T.ShaderMaterial
		side={DoubleSide}
		vertexShader={vertex}
		fragmentShader={fragment}
		transparent
		{uniforms}
	/>
	{#each shells as _, i}
		<Instance />
	{/each}
</InstancedMesh>
