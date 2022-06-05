import { expect, test } from "@playwright/test";

test("basic areas", async ({ page }) => {
  await page.goto("/");
  await page.locator("text=stats");
  await page.locator("text=info");
  await page.locator("text=prof");
  await page.locator("text=save");
  await page.locator("text=skills");
  await page.locator("text=profs");
  await page.locator("text=combat");
  await page.locator("text=weapons");
  await page.locator("text=traits");
});
