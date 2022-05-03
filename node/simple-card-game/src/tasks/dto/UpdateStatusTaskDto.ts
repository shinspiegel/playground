import { IsNotEmpty, IsEnum } from 'class-validator';
import { TaskStatus } from '../tasks.model';

export class UpdateStatusTaskDto {
  @IsNotEmpty()
  @IsEnum(TaskStatus)
  status: TaskStatus;
}
