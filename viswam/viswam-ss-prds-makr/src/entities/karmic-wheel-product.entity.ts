import { Column } from 'typeorm';
import { BaseEntity } from '../common/base-repository/base-entity';

export class KarmicWheelProduct extends BaseEntity {
  @Column()
  name: string;

  @Column()
  website: string;
}
