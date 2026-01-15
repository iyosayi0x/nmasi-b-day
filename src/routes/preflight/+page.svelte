<script lang="ts">
	import { goto } from '$app/navigation';
	import Icon from '@iconify/svelte';
	const PERSISTENCE_KEY_NAME = 'PREFLIGHT_CHECKLIST';

	const clickSound = '/sounds/mouse-click.mp3';
	import { browser } from '$app/environment';

	/**
	 * click audio
	 */
	let clickSoundAudio: HTMLAudioElement | null = $state(null);

	/**
	 * state
	 */
	let preflightTasks = $state([
		{
			id: '1',
			label: "Ensure you're not using that useless safari browser",
			isDone: false
		},
		{
			id: '2',
			label: 'Maximize your browser window',
			isDone: false
		},
		{
			id: '3',
			label: 'Enable audio',
			hint: 'Best with headphones 🎧',
			isDone: false
		},
		{
			id: '4',
			label: 'Prepare for a walk down memory lane',
			isDone: false
		}
	]);

	/**
	 * methods
	 */

	const handleTaskAction = (taskId: string) => {
		if (taskId === '3') {
			if (clickSoundAudio) {
				clickSoundAudio.currentTime = 0;
				clickSoundAudio.play();
			}
		}
	};

	const handleTaskDone = (id: string, checked: boolean) => {
		preflightTasks = preflightTasks.map((task) => {
			if (task.id === id) {
				return { ...task, isDone: checked };
			}
			return task;
		});

		sessionStorage.setItem(PERSISTENCE_KEY_NAME, JSON.stringify(preflightTasks));

		handleTaskAction(id);
	};

	const handleEnterStory = () => {
		goto('/story');
	};

	const allTasksDone = $derived.by(() => {
		return preflightTasks.every((task) => task.isDone);
	});

	/**
	 * side effects
	 */
	$effect(() => {
		/**
		 * load tasks - merge stored isDone state with current tasks
		 * This ensures new tasks aren't lost when loading old persisted data
		 */
		const storedTasks = sessionStorage.getItem(PERSISTENCE_KEY_NAME);
		if (storedTasks) {
			const parsedTasks: typeof preflightTasks = JSON.parse(storedTasks);
			const storedTaskMap = new Map(parsedTasks.map((t) => [t.id, t.isDone]));

			// Merge: keep current tasks, but restore isDone state from storage
			preflightTasks = preflightTasks.map((task) => ({
				...task,
				isDone: storedTaskMap.get(task.id) ?? task.isDone
			}));
		}

		/**
		 * load audio
		 */
		clickSoundAudio = browser ? new Audio(clickSound) : null;
	});
</script>

<div class="relative min-h-screen w-full overflow-hidden">
	<!-- Background Elements -->
	<div class="ambient-bg fixed inset-0 z-0" aria-hidden="true"></div>
	<div class="background-grid pointer-events-none absolute inset-0 z-0 opacity-20"></div>

	<!-- Decorative Floating Elements -->
	<div class="floating-elements pointer-events-none absolute inset-0 z-10">
		<div class="element animate-float absolute top-[10%] left-[5%] text-accent/20">
			<Icon icon="ph:sparkle-fill" class="text-3xl" />
		</div>
		<div class="element animate-float-slow absolute top-[15%] right-[10%] text-accent/15">
			<Icon icon="ph:star-fill" class="text-xl" />
		</div>
		<div class="element animate-float-slower absolute bottom-[20%] left-[15%] text-accent/25">
			<Icon icon="ph:sparkle-bold" class="text-4xl" />
		</div>
		<div class="element animate-float absolute right-[5%] bottom-[10%] text-accent/10">
			<Icon icon="ph:star-bold" class="text-6xl" />
		</div>
	</div>

	<!-- Main Content -->
	<main class="relative z-10 flex min-h-screen w-full flex-col items-center justify-center p-4">
		<!-- Preflight Modal -->
		<div
			class="glass-panel group/panel flex w-full max-w-lg transform flex-col items-center rounded-2xl p-8 text-center transition-all duration-700 md:p-12"
			role="dialog"
			aria-labelledby="modal-title"
			aria-describedby="modal-description"
		>
			<div
				class="absolute inset-0 -z-10 rounded-2xl bg-accent/5 opacity-0 transition-opacity duration-500 group-hover/panel:opacity-100"
			></div>

			<!-- Header -->
			<header class="mb-10 space-y-4">
				<div
					class="mb-4 inline-flex h-14 w-14 items-center justify-center rounded-2xl border border-accent/20 bg-accent/10 shadow-[0_0_20px_rgba(168,85,247,0.15)] md:h-16 md:w-16"
					aria-hidden="true"
				>
					<Icon icon="ph:list-bullets-bold" class="text-3xl text-accent"></Icon>
				</div>
				<h1
					id="modal-title"
					class="animate-reveal text-3xl font-black tracking-tight text-ghost md:text-5xl"
				>
					Setting the Stage
				</h1>
				<p
					id="modal-description"
					class="animate-fade-in-up mx-auto max-w-xs text-sm font-medium text-white/40 md:text-base"
					style="animation-delay: 0.2s"
				>
					Prepare your space for the journey ahead. Complete the ritual to unlock the story.
				</p>
			</header>

			<!-- Preflight Checklist -->
			<section
				class="animate-fade-in-up mb-10 w-full space-y-4 text-left"
				aria-label="Preflight checklist"
				style="animation-delay: 0.4s"
			>
				{#each preflightTasks as task}
					<label
						class="custom-checkbox group flex cursor-pointer items-center gap-5 rounded-xl border border-white/0 bg-white/0 p-3 transition-all select-none hover:border-white/5 hover:bg-white/5"
					>
						<input
							type="checkbox"
							class="peer hidden"
							aria-label={task.label}
							checked={task.isDone}
							onchange={(e) => {
								const evt = e as unknown as Event & { target: { checked: boolean } };
								handleTaskDone(task.id, evt.target.checked);
							}}
						/>
						<div
							class="flex h-7 w-7 shrink-0 items-center justify-center rounded-lg border-2 border-accent/30 shadow-[0_0_10px_rgba(168,85,247,0.1)] transition-all duration-300 group-hover:border-accent peer-checked:border-accent peer-checked:bg-accent"
							aria-hidden="true"
						>
							<Icon icon="ph:check-bold" class="hidden text-midnight group-peer-checked:block" />
						</div>
						<div class="flex flex-col">
							<span
								class="text-base font-bold tracking-wide text-ghost/80 transition-all peer-checked:text-ghost/40 peer-checked:line-through peer-checked:decoration-accent/50"
							>
								{task.label}
							</span>
							{#if task.hint}
								<span class="text-xs font-medium text-white/20">{task.hint}</span>
							{/if}
						</div>
					</label>
				{/each}
			</section>

			<!-- Call to Action -->
			<button
				type="button"
				class="group relative w-full overflow-hidden rounded-full border border-accent/50 bg-transparent py-4 font-black tracking-[0.2em] transition-all hover:scale-[1.02] hover:border-accent disabled:cursor-not-allowed disabled:opacity-30 disabled:hover:scale-100"
				aria-label="Enter the story"
				disabled={!allTasksDone}
				onclick={handleEnterStory}
			>
				<div
					class="absolute inset-0 translate-y-full bg-accent transition-transform duration-300 group-hover:translate-y-0"
					aria-hidden="true"
				></div>
				<span
					class="relative z-10 flex items-center justify-center gap-3 text-sm transition-colors duration-300 group-hover:text-midnight"
				>
					<span>ENTER THE STORY</span>
					<Icon icon="ph:arrow-right-bold" class="text-lg" aria-hidden="true" />
				</span>
			</button>

			<!-- Footer Note -->
			<footer class="mt-8 w-full border-t border-white/5 pt-6">
				<p
					class="flex items-center justify-center gap-2 text-[10px] font-bold tracking-widest text-white/20 uppercase"
				>
					<Icon icon="ph:desktop-fill" />
					Optimized for Desktop Viewing
				</p>
			</footer>
		</div>
	</main>
</div>

<style>
	.background-grid {
		background-image:
			linear-gradient(var(--color-accent) 1px, transparent 1px),
			linear-gradient(90deg, var(--color-accent) 1px, transparent 1px);
		background-size: 80px 80px;
		mask-image: radial-gradient(circle at center, black 0%, transparent 80%);
	}

	/* Glass Panel Effect */
	.glass-panel {
		background: rgba(255, 255, 255, 0.02);
		backdrop-filter: blur(20px);
		-webkit-backdrop-filter: blur(20px);
		border: 1px solid rgba(255, 255, 255, 0.05);
		box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
	}

	.custom-checkbox input:checked + div {
		background-color: var(--color-accent);
		border-color: var(--color-accent);
	}

	.custom-checkbox input:checked + div :global(svg) {
		display: block;
	}

	.ambient-bg {
		background: radial-gradient(circle at 50% 50%, #120b1e 0%, #0a0a0a 100%);
	}

	@keyframes float {
		0%,
		100% {
			transform: translateY(0) rotate(0deg);
		}
		50% {
			transform: translateY(-20px) rotate(5deg);
		}
	}

	@keyframes float-slow {
		0%,
		100% {
			transform: translateY(0) rotate(0deg);
		}
		50% {
			transform: translateY(-40px) rotate(-10deg);
		}
	}

	@keyframes float-slower {
		0%,
		100% {
			transform: translateY(0) rotate(0deg);
		}
		50% {
			transform: translateY(-60px) rotate(15deg);
		}
	}

	.animate-float {
		animation: float 8s ease-in-out infinite;
	}
	.animate-float-slow {
		animation: float-slow 12s ease-in-out infinite;
	}
	.animate-float-slower {
		animation: float-slower 18s ease-in-out infinite;
	}

	@keyframes reveal {
		0% {
			transform: translateY(20px);
			opacity: 0;
		}
		100% {
			transform: translateY(0);
			opacity: 1;
		}
	}

	@keyframes fade-in-up {
		0% {
			transform: translateY(15px);
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
