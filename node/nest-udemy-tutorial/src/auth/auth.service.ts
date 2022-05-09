import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcrypt';
import { UserEntity, UserModel } from '../users/entities/user.entity';
import { SignInDto } from './dto/signin.dto';
import { SignUpDto } from './dto/signup';
import { AccessTokenInterface } from './dto/token.interface';
import { JwtPayload } from './interfaces/JwtPayload';

@Injectable()
export class AuthService {
  constructor(private jwtService: JwtService) {}

  async signUp(credentials: SignUpDto): Promise<UserModel> {
    return await UserEntity.createUser(credentials);
  }

  async signIn({
    username,
    password,
  }: SignInDto): Promise<AccessTokenInterface> {
    const user = await UserEntity.findOneBy({ username });

    if (!user) {
      throw new UnauthorizedException();
    }

    const isPasswordMatch = await bcrypt.compare(password, user.password);

    if (!isPasswordMatch) {
      throw new UnauthorizedException();
    }

    const payload: JwtPayload = { username: user.username };

    const accessToken = await this.jwtService.sign(payload);

    return { accessToken };
  }
}
