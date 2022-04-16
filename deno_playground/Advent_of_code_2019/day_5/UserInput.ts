async function UserInput() {
  const buf = new Uint8Array(1024);
  const n = await Deno.stdin.read(buf);
  return new TextDecoder().decode(buf.subarray(0, n!)).trim();
}

export default UserInput;
