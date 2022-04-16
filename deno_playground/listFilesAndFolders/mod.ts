const dirlist = await Deno.readDir(".");

for await (const dir of dirlist) {
    console.log(dir);
}
