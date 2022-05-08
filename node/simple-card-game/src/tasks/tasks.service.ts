import { Injectable, NotFoundException } from '@nestjs/common';
import { TaskEntity, TaskModel, TaskStatus } from './entities/task.entity';
import { GetTaskFilterDto } from './dto/GetTaskFilterDto';
import { UserEntity } from 'src/users/entities/user.entity';

@Injectable()
export class TasksService {
  private tasks: any[] = [];

  async all({
    filter,
    user,
  }: {
    filter: GetTaskFilterDto;
    user: UserEntity;
  }): Promise<TaskModel[]> {
    let tasks = await TaskEntity.find({ where: { user: { id: user.id } } });

    if (filter.status) {
      tasks = tasks.filter((t) => t.status === filter.status);
    }

    if (filter.value) {
      tasks = tasks.filter((t) => t.value === filter.value);
    }

    return tasks;
  }

  async create({
    value,
    user,
  }: {
    value: string;
    user: UserEntity;
  }): Promise<TaskModel> {
    const task = TaskEntity.create({
      value,
      status: TaskStatus.OPEN,
      user,
    });

    await task.save();

    return task;
  }

  async getById({
    id,
    user,
  }: {
    id: TaskModel['id'];
    user: UserEntity;
  }): Promise<TaskModel | undefined> {
    const task = await TaskEntity.findOneBy({ id, user: { id: user.id } });

    if (!task) {
      throw new NotFoundException(`Task ${id} not found.`);
    }

    return task;
  }

  async updateTaskStatus({
    id,
    status,
    user,
  }: {
    id: TaskModel['id'];
    status: TaskModel['status'];
    user: UserEntity;
  }): Promise<TaskModel> {
    const task = await TaskEntity.findOneBy({ id, user: { id: user.id } });

    if (!task) {
      throw new NotFoundException(`Task ${id} not found.`);
    }

    task.status = status;
    task.save();
    return task;
  }

  async deleteById({
    id,
    user,
  }: {
    user: UserEntity;
    id: TaskModel['id'];
  }): Promise<void> {
    const task = await TaskEntity.findOneBy({ id, user: { id: user.id } });

    if (!task) {
      throw new NotFoundException(`Task ${id} not found.`);
    }

    await task.remove();
  }
}
