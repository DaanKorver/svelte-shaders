<script lang="ts">
	import { onMount } from 'svelte';
	import { createGrass } from './grass';
	import { useFrame, useThrelte } from '@threlte/core';

	const { scene } = useThrelte();

	const uniforms = {
		uTime: {
			value: 0
		}
	};

	onMount(() => {
		const m = createGrass({ uniforms });
		console.log(m);

		scene.add(m);
	});

	useFrame(({ clock }) => {
		uniforms.uTime.value = clock.getElapsedTime();
	});
</script>
