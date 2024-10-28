import { DataSource } from 'typeorm';
import { Feature } from '../../entities/feature.entity';

export const featureProviders = [
  {
    provide: 'FEATURE_REPOSITORY',
    useFactory: (dataSource: DataSource) => dataSource.getRepository(Feature),
    inject: ['DATA_SOURCE'],
  },
];
