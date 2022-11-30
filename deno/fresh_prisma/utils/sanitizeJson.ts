export class SanitizeJsonError extends Error {
  constructor(message: string) {
    super(message);
  }
}

export type Fields<FieldName extends string> = {
  name: FieldName;
};

export function sanitizeJson<FieldName extends string>(
  json: string,
  fields: Fields<FieldName>[]
): Record<FieldName, string> {
  const dirtyObject = JSON.parse(json);
  const formValidated = {} as Record<FieldName, string>;
  const errors: string[] = [];

  fields.forEach(({ name }) => {
    const property = dirtyObject[name];

    if (!property) {
      errors.push(`invalid or empty ${name}`);
    }
  });

  if (errors.length > 0) {
    throw new SanitizeJsonError(`Error: ${errors.join(", ")}`);
  }

  return formValidated;
}
