import { Module } from '@nestjs/common';

import { DatabaseModule } from 'src/common/db/database.module';
import { karmicWheelProductProviders } from './karmic-wheel-product.providers';

import { KarmicWheelProductService } from './karmic-wheel-product.service';
import { KarmicWheelProductController } from './karmic-wheel-product.controller';

@Module({
  imports: [DatabaseModule],
  controllers: [KarmicWheelProductController],
  providers: [...karmicWheelProductProviders, KarmicWheelProductService],
})
export class KarmicWheelProductModule {}
