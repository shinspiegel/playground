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
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CreateTaskDto } from './dto/CreateTaskDto';
import { GetTaskFilterDto } from './dto/GetTaskFilterDto';
import { UpdateStatusTaskDto } from './dto/UpdateStatusTaskDto';
import { TaskModel } from './entities/task.entity';
import { TasksService } from './tasks.service';

@Controller('tasks')
@UseGuards(AuthGuard())
export class TasksController {
  constructor(private service: TasksService) {}

  @Get()
  async getTask(@Query() query: GetTaskFilterDto): Promise<TaskModel[]> {
    return this.service.all(query);
  }

  @Post()
  @HttpCode(201)
  async create(@Body() body: CreateTaskDto): Promise<TaskModel> {
    return this.service.create(body);
  }

  @Get('/:id')
  async single(@Param('id') id: string): Promise<TaskModel> {
    return this.service.getById(id);
  }

  @Patch('/:id/status')
  async patch(
    @Param('id') id: string,
    @Body() body: UpdateStatusTaskDto,
  ): Promise<TaskModel> {
    return this.service.updateTaskStatus(id, body.status);
  }

  @Delete('/:id')
  async delete(@Param('id') id: string): Promise<void> {
    return this.service.deleteById(id);
  }
}
