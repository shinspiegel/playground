type Measures = {
  value: number;
  variant?: "increase" | "decrease";
};

export const partOne = (enable: boolean, data: number[]) => {
  const values: Measures[] = [];

  data.forEach((item, index) => {
    if (values.length < 1) {
      values.push({ value: item });
      return;
    }

    const lastValue = values[index - 1].value;

    values.push({
      value: item,
      variant: lastValue < item ? "increase" : "decrease",
    });
  });

  const amount = [...values].filter((v) => v.variant === "increase").length;

  if (enable) console.log(amount);
};
