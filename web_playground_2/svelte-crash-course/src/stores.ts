import { writable } from "svelte/store";
import { FeedbackLocalStorage } from "./localStorage";
import type { Feedback } from "./types";

export const FeedbackStore = writable<Feedback[]>(FeedbackLocalStorage.get());

FeedbackStore.subscribe((value) => FeedbackLocalStorage.set(value));
