<script lang="ts">
	import { onMount } from 'svelte';
	import { gsap } from '$lib/index';
	import { supabase } from '$lib/supabase';

	let galleryItems = $state<any[]>([]);
	let galleryRef = $state<HTMLElement>();
	let currentIndex = $state(0);
	let isDragging = $state(false);

	onMount(async () => {
		const { data, error } = await supabase
			.from('gallery_images')
			.select('*')
			.order('display_order', { ascending: true });

		if (!error && data) {
			galleryItems = data;
		}

		if (galleryRef) {
			gsap.to('.gallery-item', {
				y: 'random(-20, 20)',
				duration: 'random(2, 4)',
				repeat: -1,
				yoyo: true,
				ease: 'sine.inOut'
			});

			// Track scroll position for progress indicator
			galleryRef.addEventListener('scroll', updateProgress);
		}
	});

	function updateProgress() {
		if (!galleryRef) return;
		const scrollLeft = galleryRef.scrollLeft;
		const scrollWidth = galleryRef.scrollWidth - galleryRef.clientWidth;
		const progress = scrollLeft / scrollWidth;
		currentIndex = Math.round(progress * (galleryItems.length - 1));
	}

	function scrollToIndex(index: number) {
		if (!galleryRef) return;
		const itemWidth = 200 + 24; // width + gap
		galleryRef.scrollTo({
			left: index * itemWidth,
			behavior: 'smooth'
		});
	}
</script>

<div class="relative h-full overflow-hidden">
	<!-- Enhanced Gallery Container -->
	<div
		class="gallery-container scrollbar-hide pointer-events-auto flex snap-x gap-6 overflow-x-auto pb-8"
		bind:this={galleryRef}
		role="button"
		aria-label="Memory gallery"
		onmousedown={() => (isDragging = true)}
		onmouseup={() => (isDragging = false)}
		onmouseleave={() => (isDragging = false)}
		tabindex="0"
	>
		{#each galleryItems as item, index}
			<div
				class="gallery-item group relative h-[240px] w-[200px] shrink-0 origin-bottom snap-center transition-all duration-300"
				class:scale-95={currentIndex !== index}
				class:opacity-60={currentIndex !== index}
			>
				<!-- Enhanced Card Design -->
				<div
					class="relative h-full overflow-hidden rounded-2xl border border-white/20 bg-white/5 shadow-2xl backdrop-blur-sm transition-all duration-500 lg:group-hover:border-accent/50 lg:group-hover:shadow-accent/20"
				>
					<!-- Media (Image or Video) -->
					{#if item.media_type === 'VIDEO'}
						<video
							src={item.url}
							class="h-full w-full object-cover transition-transform duration-700 lg:group-hover:scale-110"
							muted
							loop
							autoplay
							playsinline
						>
							<track kind="captions" />
						</video>
					{:else}
						<img
							src={item.url}
							alt={item.label}
							class="h-full w-full object-cover transition-transform duration-700 lg:group-hover:scale-110"
							draggable="false"
						/>
					{/if}

					<!-- Enhanced Gradient Overlay -->
					<div
						class="absolute inset-0 bg-linear-to-t from-midnight via-midnight/50 to-transparent"
					></div>

					<!-- Accent Border Glow on Hover -->
					<div
						class="absolute inset-0 rounded-2xl opacity-0 shadow-[inset_0_0_20px_rgba(255,107,107,0.3)] transition-opacity duration-500 lg:group-hover:opacity-100"
					></div>

					<!-- Enhanced Info Bar -->
					<div class="absolute inset-x-0 bottom-0 p-4">
						<div class="flex items-end justify-between">
							<div class="flex-1">
								<span
									class="block text-xs font-black tracking-widest text-accent uppercase drop-shadow-lg"
									>{item.label}</span
								>
								<span class="mt-1 block font-mono text-[10px] text-ghost/60"
									>{item.display_time}</span
								>
							</div>

							<!-- Item Number Badge -->
							<div
								class="flex h-8 w-8 items-center justify-center rounded-full border border-accent/30 bg-accent/10 backdrop-blur-sm"
							>
								<span class="font-mono text-xs font-bold text-accent">{index + 1}</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		{/each}
	</div>

	<!-- Enhanced Navigation & Progress Bar -->
	<div class="mt-6 flex items-center justify-between">
		<!-- Instruction Text -->
		<div class="flex items-center gap-2">
			<svg class="h-4 w-4 text-accent" fill="none" viewBox="0 0 24 24" stroke="currentColor">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
			</svg>
			<p class="text-[10px] font-bold tracking-wider text-ghost/50 uppercase">
				Drag or scroll to explore
			</p>
			<svg class="h-4 w-4 text-accent" fill="none" viewBox="0 0 24 24" stroke="currentColor">
				<path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
			</svg>
		</div>

		<!-- Enhanced Progress Dots -->
		<div class="flex items-center gap-2">
			{#each galleryItems.slice(0, Math.min(5, galleryItems.length)) as _, index}
				<button
					class="group relative transition-all duration-300"
					onclick={() => scrollToIndex(index)}
					aria-label="Go to slide {index + 1}"
				>
					<div
						class="h-1.5 rounded-full transition-all duration-300"
						class:w-10={currentIndex === index}
						class:bg-accent={currentIndex === index}
						class:shadow-[0_0_10px_rgba(255,107,107,0.5)]={currentIndex === index}
						class:w-1.5={currentIndex !== index}
					></div>
				</button>
			{/each}

			{#if galleryItems.length > 5}
				<div class="ml-1 h-1.5 w-1.5 rounded-full bg-white/10"></div>
			{/if}
		</div>
	</div>

	<!-- Item Counter -->
	<div class="mt-3 text-center">
		<span class="font-mono text-xs text-ghost/40">
			{currentIndex + 1} / {galleryItems.length}
		</span>
	</div>
</div>

<style>
	.scrollbar-hide::-webkit-scrollbar {
		display: none;
	}

	.scrollbar-hide {
		-ms-overflow-style: none;
		scrollbar-width: none;
	}
</style>
