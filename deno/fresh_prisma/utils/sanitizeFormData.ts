export class SanitizeFormDataError extends Error {
  constructor(message: string) {
    super(message);
  }
}

export type Fields<FieldName extends string> = {
  name: FieldName;
  type: "string" | "number";
};

export function sanitizeFormData<FieldName extends string>(
  form: FormData,
  fields: Fields<FieldName>[]
): Record<FieldName, string> {
  const formValidated = {} as Record<FieldName, string>;
  const errors: string[] = [];

  fields.forEach(({ name, type }) => {
    const data = form.get(name);

    if (!data || typeof data !== type) {
      errors.push(`invalid or empty ${name}`);
    }

    formValidated[name] = data as string;
  });

  if (errors.length > 0) {
    throw new SanitizeFormDataError(`Error: ${errors.join(", ")}`);
  }

  return formValidated;
}
