import type { Feedback } from "./types";

const LOCAL_STORAGE_NAME = "feedback";

export class FeedbackLocalStorage {
  static get(): Feedback[] {
    if (localStorage.getItem(LOCAL_STORAGE_NAME)) {
      return JSON.parse(localStorage.getItem(LOCAL_STORAGE_NAME));
    }

    return [];
  }

  static set(list: Feedback[]) {
    return localStorage.setItem(LOCAL_STORAGE_NAME, JSON.stringify(list));
  }
}
