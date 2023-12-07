<script lang="ts">
	import { useFrame } from '@threlte/core';
	import Stats from 'stats.js';
	import { onDestroy, onMount } from 'svelte';
	const stats = new Stats();

	onMount(() => {
		document.body.appendChild(stats.dom);
	});

	onDestroy(() => {
		stats.dom.remove();
	});

	useFrame(
		() => {
			stats.begin();
		},
		{
			order: -Infinity
		}
	);

	useFrame(
		() => {
			stats.end();
		},
		{
			order: Infinity
		}
	);
</script>
