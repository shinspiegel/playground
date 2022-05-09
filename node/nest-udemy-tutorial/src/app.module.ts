import { Module } from '@nestjs/common';
import { TypeOrmModule, TypeOrmModuleOptions } from '@nestjs/typeorm';
import { AuthModule } from './auth/auth.module';
import { TasksModule } from './tasks/tasks.module';

const SQL_CONFIG: TypeOrmModuleOptions = {
  type: 'sqlite',
  database: process.env.DATA_BASE_NAME,
  entities: [__dirname + '/**/*.entity{.ts,.js}'],
  synchronize: true,
};

@Module({
  imports: [TypeOrmModule.forRoot(SQL_CONFIG), AuthModule, TasksModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
