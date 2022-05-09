import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';
import { JwtStrategy } from './strategies/jwt.strategy';
import { UserEntity } from '../users/entities/user.entity';

const PASSPORT_OPTIONS = {
  defaultStrategy: 'jwt',
};

const JWT_OPTIONS = {
  secret: process.env.JWT_SECRET,
  signOptions: { expiresIn: 3600 },
};

@Module({
  imports: [
    PassportModule.register(PASSPORT_OPTIONS),
    JwtModule.register(JWT_OPTIONS),
    UserEntity,
  ],
  providers: [AuthService, JwtStrategy],
  controllers: [AuthController],
  exports: [JwtStrategy, PassportModule],
})
export class AuthModule {}
