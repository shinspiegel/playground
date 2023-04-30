import { assertEquals } from "https://deno.land/std@0.182.0/testing/asserts.ts";
import { ThirteenMonthCalendar } from "./main.ts";

Deno.test("Epoch 0", () => {
    const entry = new ThirteenMonthCalendar(0);

    assertEquals(entry.second, 0);
    assertEquals(entry.minute, 0);
    assertEquals(entry.hour, 0);
    assertEquals(entry.day, 1);
    assertEquals(entry.month, 1);
    assertEquals(entry.year, 1970);
});

Deno.test("Epoch 1589106630000 | 2020-05-10T10:30:30", () => {
    const entry = new ThirteenMonthCalendar(1589106630000);

    assertEquals(entry.second, 0);
    assertEquals(entry.minute, 0);
    assertEquals(entry.hour, 0);
    assertEquals(entry.day, 1);
    assertEquals(entry.month, 1);
    assertEquals(entry.year, 1970);
});
