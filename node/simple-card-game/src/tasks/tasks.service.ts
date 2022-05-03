import { Injectable, NotFoundException } from '@nestjs/common';
import { TaskModel, TaskStatus } from './tasks.model';
import { v4 } from 'uuid';
import { CreateTaskDto } from './dto/CreateTaskDto';
import { GetTaskFilterDto } from './dto/GetTaskFilterDto';

@Injectable()
export class TasksService {
  private tasks: TaskModel[] = [];

  all(filter: GetTaskFilterDto = {}): TaskModel[] {
    let tasks = [...this.tasks];

    if (filter.status) {
      tasks = tasks.filter((t) => t.status === filter.status);
    }

    if (filter.value) {
      tasks = tasks.filter((t) => t.value === filter.value);
    }

    return tasks;
  }

  create(task: CreateTaskDto): TaskModel {
    const newTask: TaskModel = { ...task, id: v4(), status: TaskStatus.OPEN };
    this.tasks.push(newTask);
    return newTask;
  }

  getById(id: TaskModel['id']): TaskModel | undefined {
    const task = this.tasks.find((t) => t.id === id);
    if (!task) throw new NotFoundException(`Task ${id} not found.`);
    return task;
  }

  updateTaskStatus(id: TaskModel['id'], status: TaskModel['status']) {
    const task = this.tasks.find((t) => t.id === id);
    if (!task) throw new NotFoundException(`Task ${id} not found.`);
    task.status = status;
    return task;
  }

  deleteById(id: TaskModel['id']): void {
    this.tasks.filter((t) => t.id !== id);
  }
}
