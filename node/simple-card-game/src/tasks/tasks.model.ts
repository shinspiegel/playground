export class TaskModel {
  id: string;
  value: string;
  status: TaskStatus;
}

export enum TaskStatus {
  OPEN = 'open',
  IN_PROGRESS = 'in_progress',
  DONE = 'done',
}
