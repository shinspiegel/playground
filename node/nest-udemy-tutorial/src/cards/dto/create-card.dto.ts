import { IsString, IsNotEmpty } from 'class-validator';

export class CreateCardDto {
  @IsNotEmpty()
  @IsString()
  name: string;
}
