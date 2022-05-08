import { IsString, MinLength, IsNotEmpty } from 'class-validator';

export class SignUpDto {
  @IsString()
  @MinLength(4)
  @IsNotEmpty()
  username: string;

  @IsString()
  @MinLength(4)
  @IsNotEmpty()
  password: string;
}
