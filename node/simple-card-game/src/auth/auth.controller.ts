import { Body, Controller, Post } from '@nestjs/common';
import { UserModel } from 'src/users/entities/user.entity';
import { AuthService } from './auth.service';
import { SignInDto } from './dto/signin.dto';
import { SignUpDto } from './dto/signup';
import { AccessTokenInterface } from './dto/token.interface';

@Controller('auth')
export class AuthController {
  constructor(private service: AuthService) {}

  @Post('signup')
  signUp(@Body() credentials: SignUpDto): Promise<UserModel> {
    return this.service.signUp(credentials);
  }

  @Post('signin')
  signIn(@Body() credentials: SignInDto): Promise<AccessTokenInterface> {
    return this.service.signIn(credentials);
  }
}
