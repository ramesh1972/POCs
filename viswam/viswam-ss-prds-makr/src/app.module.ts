import { Module } from '@nestjs/common';
import { RouterModule } from '@nestjs/core';
import { routes } from './routes';
import { AppController } from './app.controller';
import { AppService } from './app.service';

import { FeatureModule } from './controllers/feature/feature.module';
import { KarmicWheelProductModule } from './controllers/karmic-wheel-product/karmic-wheel-product.module';

@Module({
  imports: [
    FeatureModule,
    KarmicWheelProductModule,
    RouterModule.register(routes),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
