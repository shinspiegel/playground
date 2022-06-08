import { renderHook, act } from "@testing-library/react-hooks";
import { useCount } from "./index";

test("should return a base count with zero", () => {
  const { result } = renderHook(() => useCount());
  expect(result.current.count).toBe(0);
});

test("should create a base count with initial value", () => {
  const { result } = renderHook(() => useCount({ initialValue: 10 }));
  expect(result.current.count).toBe(10);
});

test("should be able to increment", () => {
  const { result } = renderHook(() => useCount());
  expect(result.current.count).toBe(0);
  act(() => result.current.increment());
  expect(result.current.count).toBe(1);
});
