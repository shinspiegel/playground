import { IsOptional, IsEnum, IsString } from 'class-validator';
import { TaskStatus } from '../entities/task.entity';

export class GetTaskFilterDto {
  @IsOptional()
  @IsEnum(TaskStatus)
  status?: TaskStatus;

  @IsOptional()
  @IsString()
  value?: string;
}
