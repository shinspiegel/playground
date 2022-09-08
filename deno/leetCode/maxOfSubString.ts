function lengthOfLongestSubstring(text: string): number {
  const n = text.length;
  let res = 0;

  for (let i = 0; i < n; i++) {
    const visited = new Array(256);

    for (let j = i; j < n; j++) {
      if (visited[text.charCodeAt(j)] === true) {
        break;
      } else {
        res = Math.max(res, j - i + 1);
        visited[text.charCodeAt(j)] = true;
      }
    }
  }

  return res;
}
