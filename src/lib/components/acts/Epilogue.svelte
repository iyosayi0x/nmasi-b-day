<script lang="ts">
	import { fade } from 'svelte/transition';
	import { onMount } from 'svelte';

	const letterText =
		"Dear Legend, this is more than a birthday celebration; it is a retrospective of the soul you have become. From your iconic Nsukka leap of faith jumping out of a moving Keke to the forest of impact you have grown around you, your story is written in gold. You are the architect of your own light, so keep setting your heart ablaze. Tell `mide your love` and Stephen to top this lmao,😂. This entire digital archive was curated and built by Iyosayi Onaiwu, a one-man production for a one-of-a-kind legend. As Rengoku said: 'Go beyond your limits.";
	let typewriterDisplay = $state('');
	let typewriterFinished = $state(false);

	onMount(() => {
		startTypewriter();
	});

	function startTypewriter() {
		typewriterDisplay = '';
		let i = 0;
		const interval = setInterval(() => {
			if (i < letterText.length) {
				typewriterDisplay += letterText[i];
				i++;
			} else {
				clearInterval(interval);
				typewriterFinished = true;
			}
		}, 30);
	}
</script>

<div class="flex h-full flex-col justify-between">
	<div class="max-w-2xl">
		<p class="font-mono text-xs leading-relaxed text-ghost/80 md:text-sm">
			{typewriterDisplay}
			<span class="inline-block h-4 w-1 animate-pulse bg-accent"></span>
		</p>
	</div>

	{#if typewriterFinished}
		<div class="mt-8 space-y-8" in:fade={{ delay: 500, duration: 1000 }}>
			<div class="text-center">
				<h3
					class="animate-gradient-x mb-4 bg-linear-to-r from-accent via-orange-500 to-accent bg-clip-text text-2xl font-black tracking-tighter text-transparent uppercase italic md:text-6xl"
				>
					"Set your heart ablaze. Go beyond your limits!"
				</h3>
				<p class="text-[10px] font-black tracking-widest text-ghost/40 md:text-xs">
					- KYOJURO RENGOKU
				</p>
			</div>

			<div
				class="h-[200px] w-full overflow-hidden rounded-2xl border border-white/10 bg-black shadow-2xl"
			>
				<iframe
					class="h-[200px] w-full"
					src="https://www.youtube.com/embed/dQw4w9WgXcQ?autoplay=1&mute=0"
					title="Legacy Video"
					frameborder="0"
					allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
					allowfullscreen
				></iframe>
			</div>
		</div>
	{/if}
</div>

<style>
	@keyframes gradient-x {
		0% {
			background-position: 0% 50%;
		}
		50% {
			background-position: 100% 50%;
		}
		100% {
			background-position: 0% 50%;
		}
	}

	.animate-gradient-x {
		background-size: 200% 200%;
		animation: gradient-x 3s ease infinite;
	}
</style>
