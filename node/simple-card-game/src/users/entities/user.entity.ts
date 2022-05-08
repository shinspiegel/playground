import * as bcrypt from 'bcrypt';
import { ConflictException } from '@nestjs/common';
import {
  Column,
  Entity,
  PrimaryGeneratedColumn,
  BaseEntity,
  OneToMany,
} from 'typeorm';
import { CreateUserDto } from '../dto/create-user.dto';
import { TaskEntity } from 'src/tasks/entities/task.entity';

@Entity()
export class UserEntity extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;

  @Column({ unique: true })
  username: string;

  @Column()
  password: string;

  @OneToMany((_type) => TaskEntity, (task) => task.user, { eager: true })
  tasks: TaskEntity[];

  static async createUser({
    username,
    password,
  }: CreateUserDto): Promise<UserEntity> {
    try {
      const salt = await bcrypt.genSalt();
      const hashPassword = await bcrypt.hash(password, salt);

      const user = UserEntity.create({ username, password: hashPassword });
      return await user.save();
    } catch (err) {
      if (err.code === 'SQLITE_CONSTRAINT') {
        throw new ConflictException('Username already exists');
      }

      throw err;
    }
  }
}

export type UserModel = Pick<UserEntity, 'id' | 'username'> &
  Partial<UserEntity | 'password'>;
