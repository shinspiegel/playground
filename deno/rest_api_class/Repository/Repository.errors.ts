export class RepositoryError extends Error {
  constructor(msg: string) {
    super(msg);
  }
}

export class RepositoryNoEntryCreatedError extends RepositoryError {
  constructor(tableName: string) {
    super(`No entry created on [${tableName}]`);
  }
}

export class RepositoryNoEntryDeletedError extends RepositoryError {
  constructor(tableName: string) {
    super(`No entry delete on [${tableName}]`);
  }
}

export class RepositoryNoEntryUpdatedError extends RepositoryError {
  constructor(tableName: string) {
    super(`No entry updated on [${tableName}]`);
  }
}

export class RepositoryMissingIdError extends RepositoryError {
  constructor() {
    super("Missing 'id' property on partial");
  }
}

export class RepositoryInvalidEntry extends RepositoryError {
  constructor() {
    super("Invalid or empty entry");
  }
}

export class RepositoryInvalidDataEntry extends RepositoryError {
  constructor() {
    super("Invalid database response");
  }
}

export class RepositoryMappedFailedError extends RepositoryError {
  constructor() {
    super("Failed to map data from the row into the model");
  }
}
