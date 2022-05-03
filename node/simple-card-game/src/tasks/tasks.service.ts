import { Injectable, NotFoundException } from '@nestjs/common';
import { TaskEntity, TaskModel, TaskStatus } from './entities/task.entity';
import { CreateTaskDto } from './dto/CreateTaskDto';
import { GetTaskFilterDto } from './dto/GetTaskFilterDto';

@Injectable()
export class TasksService {
  private tasks: any[] = [];

  async all(filter: GetTaskFilterDto = {}): Promise<TaskModel[]> {
    let tasks = await TaskEntity.find();

    if (filter.status) {
      tasks = tasks.filter((t) => t.status === filter.status);
    }

    if (filter.value) {
      tasks = tasks.filter((t) => t.value === filter.value);
    }

    return tasks;
  }

  async create(task: CreateTaskDto): Promise<TaskModel> {
    const newTask = new TaskEntity();
    newTask.value = task.value;
    newTask.status = TaskStatus.OPEN;
    await newTask.save();
    return newTask;
  }

  async getById(id: TaskModel['id']): Promise<TaskModel | undefined> {
    const task = await TaskEntity.firstById(id);

    if (!task) {
      throw new NotFoundException(`Task ${id} not found.`);
    }

    return task;
  }

  async updateTaskStatus(
    id: TaskModel['id'],
    status: TaskModel['status'],
  ): Promise<TaskModel> {
    const task = await TaskEntity.firstById(id);

    if (!task) {
      throw new NotFoundException(`Task ${id} not found.`);
    }

    task.status = status;
    task.save();
    return task;
  }

  async deleteById(id: TaskModel['id']): Promise<void> {
    const task = await TaskEntity.firstById(id);
    await task.remove();
  }
}
