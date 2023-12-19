<script lang="ts">
	import { onMount } from 'svelte';
	import { createGrass } from './grass';
	import { useTask, useThrelte, T } from '@threlte/core';

	const { scene, camera } = useThrelte();

	const uniforms = {
		uTime: {
			value: 0
		}
	};

	onMount(() => {
		const m = createGrass({ uniforms });
		scene.add(m);

		$camera.position.set(10, 1.3, 10);
	});

	useTask((delta) => {
		uniforms.uTime.value += delta;
	});
</script>
