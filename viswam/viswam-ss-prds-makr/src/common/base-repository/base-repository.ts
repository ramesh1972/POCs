/* import {
  Repository,
  DeepPartial,
  FindOneOptions,
  FindManyOptions,
} from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';

import { BaseEntity } from './base-entity';

export class BaseRepository<T extends BaseEntity> {
  constructor(
    @InjectRepository(T)
    private readonly repository: Repository<T>,
  ) {}

  async findAll(options?: FindManyOptions<T>): Promise<T[]> {
    return this.repository.find(options);
  }

  async findOne(id: number, options?: FindOneOptions<T>): Promise<T> {
    return this.repository.findOne(id, options);
  }

  async create(data: DeepPartial<T>): Promise<T> {
    const entity = this.repository.create(data);
    return this.repository.save(entity);
  }

  async update(id: number, data: DeepPartial<T>): Promise<T> {
    await this.repository.update(id, data);
    return this.findOne(id);
  }

  async remove(id: number): Promise<void> {
    await this.repository.delete(id);
  }
}
 */
