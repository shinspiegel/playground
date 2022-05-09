import { Injectable } from '@nestjs/common';
import { CreateCardDto } from './dto/create-card.dto';
import { UpdateCardDto } from './dto/update-card.dto';
import { CardEntity } from './entities/card.entity';

@Injectable()
export class CardsService {
  async create({ name }: CreateCardDto) {
    const card = CardEntity.create({ name });
    card.save();
    return card;
  }

  async findAll() {
    return `This action returns all cards`;
  }

  async findOne(id: CardEntity['id']) {
    return `This action returns a #${id} card`;
  }

  async update(id: CardEntity['id'], updateCardDto: UpdateCardDto) {
    return `This action updates a #${id} card`;
  }

  async remove(id: CardEntity['id']) {
    return `This action removes a #${id} card`;
  }
}
