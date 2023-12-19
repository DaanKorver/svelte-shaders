<script lang="ts">
	import { useFrame, useTask } from '@threlte/core';
	import Stats from 'stats.js';
	import { onDestroy, onMount } from 'svelte';
	const stats = new Stats();

	onMount(() => {
		document.body.appendChild(stats.dom);
	});

	onDestroy(() => {
		stats.dom.remove();
	});

	useTask(() => {
		stats.begin();
	});
	useTask(() => {
		stats.end();
	});
</script>
