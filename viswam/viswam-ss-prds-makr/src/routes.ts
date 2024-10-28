import { FeatureModule } from './controllers/feature/feature.module';
import { KarmicWheelProductModule } from './controllers/karmic-wheel-product/karmic-wheel-product.module';

export const routes = [
  {
    path: 'entities',
    module: FeatureModule,
  },
  {
    path: 'products',
    module: KarmicWheelProductModule,
  },
];
