<script lang="ts">
	import { useTask } from '@threlte/core';
	import { HTML } from '@threlte/extras';
	import { fade } from 'svelte/transition';

	let progress = $state(0);

	useTask((delta) => {
		progress = (progress + delta * 50) % 100;
	});
</script>

<HTML center transform>
	<div class="flex flex-col items-center justify-center space-y-4" in:fade>
		<div class="relative h-16 w-16">
			<div class="absolute inset-0 rounded-full border-4 border-accent/20"></div>
			<div
				class="absolute inset-0 animate-spin rounded-full border-4 border-t-accent border-r-transparent border-b-transparent border-l-transparent"
			></div>
		</div>
		<p class="animate-pulse text-xs font-bold tracking-[0.2em] text-accent uppercase">
			Loading Assets...
		</p>
	</div>
</HTML>
