import { IsNotEmpty, IsEnum } from 'class-validator';
import { TaskStatus } from '../entities/task.entity';

export class UpdateStatusTaskDto {
  @IsNotEmpty()
  @IsEnum(TaskStatus)
  status: TaskStatus;
}
