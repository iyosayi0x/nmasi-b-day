<script>
	import { goto } from '$app/navigation';
	import Icon from '@iconify/svelte';

	const onBeginJourney = () => {
		goto('/preflight');
	};
</script>

<div class="relative flex h-screen w-full flex-col items-center justify-center overflow-hidden">
	<!-- Background Elements -->
	<div class="background-grid pointer-events-none absolute inset-0 z-0 opacity-20"></div>
	<div class="ambient-glow pointer-events-none absolute inset-0 z-0"></div>

	<!-- Decorative Floating Elements -->
	<div class="floating-elements pointer-events-none absolute inset-0 z-10">
		<div class="element animate-float-slow absolute top-[15%] left-[10%] text-accent/30">
			<Icon icon="ph:sparkle-fill" class="text-4xl" />
		</div>
		<div class="element animate-float-slower absolute top-[20%] right-[15%] text-accent/20">
			<Icon icon="ph:star-fill" class="text-2xl" />
		</div>
		<div class="element animate-float absolute bottom-[25%] left-[20%] text-accent/25">
			<Icon icon="ph:sparkle-bold" class="text-3xl" />
		</div>
		<div class="element animate-float-slow absolute right-[25%] bottom-[30%] text-accent/15">
			<Icon icon="ph:star-bold" class="text-5xl" />
		</div>
	</div>

	<!-- Anniversary Badge -->
	<div
		class="badge pointer-events-none absolute top-12 right-12 z-20 flex h-24 w-24 -rotate-12 items-center justify-center rounded-full border border-accent/30 bg-accent/5 backdrop-blur-sm md:top-20 md:right-20 md:h-32 md:w-32"
	>
		<div class="text-center">
			<span class="block text-2xl font-black text-accent md:text-3xl">18</span>
			<span class="text-[10px] font-bold tracking-[0.2em] text-accent/60 uppercase md:text-xs">
				Years
			</span>
		</div>
		<div class="absolute inset-2 rounded-full border border-dashed border-accent/20"></div>
	</div>

	<!-- ---------- main --------- -->
	<main class="relative z-20 flex flex-col items-center justify-center gap-16 px-6 text-center">
		<div class="flex flex-col items-center justify-center gap-8">
			<div class="overflow-hidden">
				<h1 class="animate-reveal text-4xl font-black tracking-tight transition-all md:text-8xl">
					The Legend of <br />
					<span class="decoration-offset-8 text-accent underline decoration-accent/30"
						>Nsukka SpiderWoman</span
					>
				</h1>
			</div>
			<p
				class="animate-fade-in-up max-w-2xl text-base leading-relaxed text-ghost/70 md:text-lg"
				style="animation-delay: 0.3s"
			>
				Some lives are lived in chapters; others are written in the stars. This is a journey through
				the moments that defined eighteen transformative years, the laughter, the chaos, and the
				quiet magic in between.
			</p>
		</div>

		<div class="animate-fade-in-up" style="animation-delay: 0.6s">
			<button
				class="group relative h-16 w-72 cursor-pointer overflow-hidden rounded-full border border-accent/50 bg-transparent font-black tracking-[0.2em] transition-all hover:scale-105 hover:border-accent"
				onclick={onBeginJourney}
			>
				<div
					class="absolute inset-0 translate-y-full bg-accent transition-transform duration-300 group-hover:translate-y-0"
				></div>
				<span class="relative z-10 transition-colors duration-300 group-hover:text-midnight">
					BEGIN THE JOURNEY
				</span>
			</button>
		</div>
	</main>

	<!-- ------ circle display -----  -->
	<aside
		class="home__floating-bubble pointer-events-none fixed -right-20 -bottom-32 h-[600px] w-[600px] rounded-full"
	></aside>
</div>

<style>
	.background-grid {
		background-image:
			linear-gradient(var(--color-accent) 1px, transparent 1px),
			linear-gradient(90deg, var(--color-accent) 1px, transparent 1px);
		background-size: 100px 100px;
		mask-image: radial-gradient(circle at center, black 0%, transparent 80%);
	}

	.home__floating-bubble {
		background: linear-gradient(150deg, transparent, var(--color-accent-glow));
		filter: blur(80px);
		opacity: 0.6;
	}

	.animate-float {
		animation: float 6s ease-in-out infinite;
	}
	.animate-float-slow {
		animation: float-slow 10s ease-in-out infinite;
	}
	.animate-float-slower {
		animation: float-slower 15s ease-in-out infinite;
	}

	@keyframes reveal {
		0% {
			transform: translateY(100%);
			opacity: 0;
		}
		100% {
			transform: translateY(0);
			opacity: 1;
		}
	}

	@keyframes fade-in-up {
		0% {
			transform: translateY(30px);
			opacity: 0;
		}
		100% {
			transform: translateY(0);
			opacity: 1;
		}
	}

	.animate-reveal {
		animation: reveal 1s cubic-bezier(0.23, 1, 0.32, 1) forwards;
	}

	.animate-fade-in-up {
		opacity: 0;
		animation: fade-in-up 1s cubic-bezier(0.23, 1, 0.32, 1) forwards;
	}
</style>
