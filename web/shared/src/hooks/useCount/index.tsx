import { useState } from "react";

export type UseCountOptions = {
  initialValue?: number;
};

export type UseCount = {
  count: number;
  increment: () => void;
};

export const useCount = ({ initialValue = 0 }: UseCountOptions = {}): UseCount => {
  const [count, setCount] = useState<number>(initialValue);
  const increment = () => setCount(count + 1);

  return {
    count,
    increment,
  };
};
