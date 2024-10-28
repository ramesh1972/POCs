import { Module } from '@nestjs/common';

import { DatabaseModule } from 'src/common/db/database.module';
import { featureProviders } from './feature.providers';

import { FeatureService } from './feature.service';
import { FeatureController } from './feature.controller';

@Module({
  imports: [DatabaseModule],
  controllers: [FeatureController],
  providers: [...featureProviders, FeatureService],
})
export class FeatureModule {}
