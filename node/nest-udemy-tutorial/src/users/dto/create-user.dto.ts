import { IsString, MinLength, IsNotEmpty } from 'class-validator';

export class CreateUserDto {
  @IsString()
  @MinLength(4)
  @IsNotEmpty()
  username: string;

  @IsString()
  @MinLength(4)
  @IsNotEmpty()
  password: string;
}
