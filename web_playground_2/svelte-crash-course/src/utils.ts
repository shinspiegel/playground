import type { Feedback } from "./types";

export function calculateCount(list: any[]) {
  return list.length;
}

export function calculateAverage(list: Feedback[]) {
  const fractionLimit = 1;

  if (list.length > 0) {
    return (
      list.reduce((p, { rating }) => p + rating, 0) / list.length
    ).toFixed(fractionLimit);
  } else {
    return Number(0).toFixed(fractionLimit);
  }
}
