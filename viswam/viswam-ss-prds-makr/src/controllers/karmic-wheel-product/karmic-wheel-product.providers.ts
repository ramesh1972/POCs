import { DataSource } from 'typeorm';
import { KarmicWheelProduct } from 'src/entities/karmic-wheel-product.entity';

export const karmicWheelProductProviders = [
  {
    provide: 'KARMIC_WHEEL_REPOSITORY',
    useFactory: (dataSource: DataSource) =>
      dataSource.getRepository(KarmicWheelProduct),
    inject: ['DATA_SOURCE'],
  },
];
