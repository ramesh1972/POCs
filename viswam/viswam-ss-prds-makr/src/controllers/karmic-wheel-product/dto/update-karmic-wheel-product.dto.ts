import { PartialType } from '@nestjs/mapped-types';
import { CreateKarmicWheelProductDto } from './create-karmic-wheel-product.dto';

export class UpdateKarmicWheelProductDto extends PartialType(
  CreateKarmicWheelProductDto,
) {}
