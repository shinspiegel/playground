import { log, path } from "../deps.ts";

await log.setup({
    handlers: {
        console: new log.handlers.ConsoleHandler("DEBUG"),
        file: new log.handlers.FileHandler("WARNING", {
            filename: path.join(Deno.cwd(), "log"),
            formatter: `[${date()}] :: {levelName} -> {msg}`,
        }),
    },

    loggers: {
        default: {
            level: "DEBUG",
            handlers: ["console", "file"],
        },

        tasks: {
            level: "ERROR",
            handlers: ["console"],
        },
    },
});

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
