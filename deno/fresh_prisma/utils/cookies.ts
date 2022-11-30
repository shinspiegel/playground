export function parseCookieString(cookies: string | null | undefined): Record<string, string> {
  const cookieObject: Record<string, string> = {};

  if (cookies) {
    cookies
      .split("; ")
      .map((c) => c.split("="))
      .forEach(([key, value]) => {
        cookieObject[key] = value;
      });
  }

  return cookieObject;
}
