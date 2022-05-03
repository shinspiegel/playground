import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Param,
  Patch,
  Post,
  Query,
} from '@nestjs/common';
import { CreateTaskDto } from './dto/CreateTaskDto';
import { GetTaskFilterDto } from './dto/GetTaskFilterDto';
import { UpdateStatusTaskDto } from './dto/UpdateStatusTaskDto';
import { TaskModel } from './tasks.model';
import { TasksService } from './tasks.service';

@Controller('tasks')
export class TasksController {
  constructor(private service: TasksService) {}

  @Get()
  getTask(@Query() query: GetTaskFilterDto): TaskModel[] {
    return this.service.all(query);
  }

  @Post()
  @HttpCode(201)
  create(@Body() body: CreateTaskDto): TaskModel {
    return this.service.create(body);
  }

  @Get('/:id')
  single(@Param('id') id: string): TaskModel {
    return this.service.getById(id);
  }

  @Patch('/:id/status')
  patch(@Param('id') id: string, @Body() body: UpdateStatusTaskDto): TaskModel {
    return this.service.updateTaskStatus(id, body.status);
  }

  @Delete('/:id')
  delete(@Param('id') id: string): void {
    return this.service.deleteById(id);
  }
}
