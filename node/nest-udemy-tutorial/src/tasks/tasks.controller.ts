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
import { GetUser } from '../auth/decorators/get-users.decorator';
import { UserEntity } from '../users/entities/user.entity';
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
  async getTask(
    @Query() query: GetTaskFilterDto,
    @GetUser() user: UserEntity,
  ): Promise<TaskModel[]> {
    return this.service.all({ filter: query, user });
  }

  @Post()
  @HttpCode(201)
  async create(
    @Body() { value }: CreateTaskDto,
    @GetUser() user: UserEntity,
  ): Promise<TaskModel> {
    return this.service.create({ user, value });
  }

  @Get('/:id')
  async single(
    @Param('id') id: string,
    @GetUser() user: UserEntity,
  ): Promise<TaskModel> {
    return this.service.getById({ id, user });
  }

  @Patch('/:id/status')
  async patch(
    @Param('id') id: string,
    @Body() { status }: UpdateStatusTaskDto,
    @GetUser() user: UserEntity,
  ): Promise<TaskModel> {
    return this.service.updateTaskStatus({ id, status, user });
  }

  @Delete('/:id')
  async delete(
    @Param('id') id: string,
    @GetUser() user: UserEntity,
  ): Promise<void> {
    return this.service.deleteById({ user, id });
  }
}
