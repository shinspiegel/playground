import { Module } from '@nestjs/common';
import { TypeOrmModule, TypeOrmModuleOptions } from '@nestjs/typeorm';
import { TasksModule } from './tasks/tasks.module';

const SQL_CONFIG: TypeOrmModuleOptions = {
  type: 'sqlite',
  database: 'database.sqlite',
  entities: [__dirname + '/**/*.entity{.ts,.js}'],
  synchronize: true,
};

@Module({
  imports: [TasksModule, TypeOrmModule.forRoot(SQL_CONFIG)],
  controllers: [],
  providers: [],
})
export class AppModule {}
