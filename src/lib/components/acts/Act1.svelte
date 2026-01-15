<script lang="ts">
	import { scale } from 'svelte/transition';
	import { onMount } from 'svelte';

	const fullText =
		'"Welcome to Year 18. Your journey is officially authorized. The tree of your life has grown deep roots, and today, we celebrate the branches that reach for the sky."';

	let displayedText = $state('');

	onMount(() => {
		let i = 0;
		const interval = setInterval(() => {
			if (i < fullText.length) {
				displayedText += fullText[i];
				i++;
			} else {
				clearInterval(interval);
			}
		}, 30); // Adjust speed here

		return () => clearInterval(interval);
	});
</script>

<div class="flex flex-col items-center justify-center space-y-8">
	<button
		class="group relative cursor-pointer appearance-none border-none bg-transparent p-0 outline-hidden"
		aria-label="Open digital envelope"
	>
		<div class="flex flex-col items-center space-y-6 text-center" in:scale={{ duration: 500 }}>
			<div class="rounded-lg border border-accent/20 bg-accent/5 p-6 backdrop-blur-md">
				<p class="mb-4 min-h-[4.5rem] text-sm text-ghost/80 italic md:text-base">
					{displayedText}<span class="ml-1 inline-block h-4 w-[2px] animate-pulse bg-accent/40"
					></span>
				</p>
				<div class="mx-auto mt-4 h-px w-24 bg-accent/40"></div>
			</div>
		</div>
	</button>
</div>
