export class Logger {
  // deno-lint-ignore no-explicit-any
  static debug(...args: any[]) {
    console.debug(`DEBUG::`, ...args);
  }

  // deno-lint-ignore no-explicit-any
  static info(...args: any[]) {
    console.info(`INFO::`, ...args);
  }

  // deno-lint-ignore no-explicit-any
  static warn(...args: any[]) {
    console.warn(`WARN::`, ...args);
  }

  // deno-lint-ignore no-explicit-any
  static error(...args: any[]) {
    console.error(`ERROR::`, ...args);
  }
}
