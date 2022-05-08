import { IsNotEmpty, IsEnum } from 'class-validator';
import { TaskStatus } from '../entities/task.entity';

const opts = Object.values(TaskStatus).join(', ');
const message = `'status' should be one of the following: ${opts}`;
export class UpdateStatusTaskDto {
  @IsNotEmpty()
  @IsEnum(TaskStatus, { message })
  status: TaskStatus;
}
