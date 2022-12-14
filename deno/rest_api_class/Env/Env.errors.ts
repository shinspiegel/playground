export class EnvError extends Error {
  constructor(msg: string) {
    super(msg);
  }
}

export class FailedToReadEnvError extends EnvError {
  constructor(env: string) {
    super(`Failed to read environment variable. Please set env: [${env}]`);
  }
}

export class NaNEnvError extends EnvError {
  constructor(env: string) {
    super(`Environment variable is not a number. Please set as a number for: [${env}]`);
  }
}
