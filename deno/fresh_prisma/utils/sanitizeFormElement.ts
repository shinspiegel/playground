export class SanitizeFormElementError extends Error {
  constructor(message: string) {
    super(message);
  }
}

export type Fields<FieldName extends string> = {
  name: FieldName;
};

export function sanitizeFormElement<FieldName extends string>(
  form: HTMLFormElement,
  fields: Fields<FieldName>[]
): Record<FieldName, string> {
  const formValidated = {} as Record<FieldName, string>;
  const errors: string[] = [];

  fields.forEach(({ name }) => {
    const element = form.elements.namedItem(name);

    if (!element) {
      errors.push(`invalid or empty ${name}`);
    }

    if (element instanceof HTMLInputElement) {
      formValidated[name] = element.value;
    }
  });

  if (errors.length > 0) {
    throw new SanitizeFormElementError(`Error: ${errors.join(", ")}`);
  }

  return formValidated;
}
