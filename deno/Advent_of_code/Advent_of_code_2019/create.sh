if [ "$1" ]; then
  mkdir "day_$1"
  touch "day_$1/sample"
  touch "day_$1/input"
  touch "day_$1/mod.ts"

  echo "const input: string = await Deno.readTextFile(\"input\");" >> "day_$1/mod.ts"
  echo "const data: string[] = input.split(\"\\\n\");" >> "day_$1/mod.ts"
fi
