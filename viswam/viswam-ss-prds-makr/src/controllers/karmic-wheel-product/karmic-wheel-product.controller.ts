import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { KarmicWheelProductService } from './karmic-wheel-product.service';
import { CreateKarmicWheelProductDto } from './dto/create-karmic-wheel-product.dto';
import { UpdateKarmicWheelProductDto } from './dto/update-karmic-wheel-product.dto';

@Controller('/')
export class KarmicWheelProductController {
  constructor(
    private readonly karmicWheelProductService: KarmicWheelProductService,
  ) {}

  @Post()
  create(@Body() createKarmicWheelProductDto: CreateKarmicWheelProductDto) {
    return this.karmicWheelProductService.create(createKarmicWheelProductDto);
  }

  @Get()
  findAll() {
    return this.karmicWheelProductService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.karmicWheelProductService.findOne(+id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateKarmicWheelProductDto: UpdateKarmicWheelProductDto,
  ) {
    return this.karmicWheelProductService.update(
      +id,
      updateKarmicWheelProductDto,
    );
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.karmicWheelProductService.remove(+id);
  }
}
