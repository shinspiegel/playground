import { log, path } from "../deps.ts";

await log.setup({
    handlers: {
        console: new log.handlers.ConsoleHandler("INFO", {
            formatter: `[${time()}] :: {levelName} -> {msg}`,
        }),
        file: new log.handlers.FileHandler("INFO", {
            filename: path.join(Deno.cwd(), "info.log"),
            formatter: `[${date()}] :: {levelName} -> {msg}`,
        }),
        error: new log.handlers.FileHandler("ERROR", {
            filename: path.join(Deno.cwd(), "error.log"),
            formatter: `[${date()}] :: {levelName} -> {msg}`,
        }),
    },

    loggers: {
        default: {
            level: "DEBUG",
            handlers: ["console", "file", "error"],
        },
    },
});

function time() {
    const format = (v: number, n = 2) => String(v).padStart(n, "0");

    const now = new Date();
    const hour = format(now.getHours());
    const minutes = format(now.getMinutes());

    return `${hour}:${minutes}`;
}

function date() {
    const format = (v: number, n = 2) => String(v).padStart(n, "0");

    const now = new Date();
    const year = format(now.getFullYear(), 4);
    const month = format(now.getMonth() + 1);
    const day = format(now.getDate());
    const hour = format(now.getHours());
    const minutes = format(now.getMinutes());

    return `${year}-${month}-${day}T${hour}:${minutes}`;
}

export default log.getLogger();
