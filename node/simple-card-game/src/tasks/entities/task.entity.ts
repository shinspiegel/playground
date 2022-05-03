import { Column, Entity, PrimaryGeneratedColumn, BaseEntity } from 'typeorm';

@Entity()
export class TaskEntity extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column()
  value: string;

  @Column()
  status: TaskStatus;

  static firstById(id: string) {
    return this.createQueryBuilder('task_entity')
      .where('task_entity.id = :id', { id })
      .getOne();
  }
}

export enum TaskStatus {
  OPEN = 'open',
  IN_PROGRESS = 'in_progress',
  DONE = 'done',
}

export type TaskModel = Pick<TaskEntity, 'id' | 'value' | 'status'>;
