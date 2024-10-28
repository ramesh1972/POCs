import { Injectable, Inject } from '@nestjs/common';
import { CreateKarmicWheelProductDto } from './dto/create-karmic-wheel-product.dto';
import { UpdateKarmicWheelProductDto } from './dto/update-karmic-wheel-product.dto';
import { Repository } from 'typeorm';
import { KarmicWheelProduct } from 'src/entities/karmic-wheel-product.entity';

@Injectable()
export class KarmicWheelProductService {
  constructor(
    @Inject('KARMIC_WHEEL_REPOSITORY')
    private karmicWheelRepository: Repository<KarmicWheelProduct>,
  ) {}

  create(createKarmicWheelProductDto: CreateKarmicWheelProductDto) {
    this.karmicWheelRepository.save(createKarmicWheelProductDto);
    return 'This action adds a new karmicWheelProduct';
  }

  findAll() {
    return this.karmicWheelRepository.find();
  }

  findOne(id: number) {
    return this.karmicWheelRepository.findOne({ where: { id } });
  }

  update(id: number, updateKarmicWheelProductDto: UpdateKarmicWheelProductDto) {
    this.karmicWheelRepository.update(id, updateKarmicWheelProductDto);
    return `This action updates a #${id} karmicWheelProduct`;
  }

  remove(id: number) {
    this.karmicWheelRepository.delete(id);
    return `This action removes a #${id} karmicWheelProduct`;
  }
}
