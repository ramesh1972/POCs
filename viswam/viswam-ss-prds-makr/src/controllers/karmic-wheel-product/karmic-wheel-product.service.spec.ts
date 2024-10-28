import { Test, TestingModule } from '@nestjs/testing';
import { KarmicWheelProductService } from './karmic-wheel-product.service';

describe('KarmicWheelProductService', () => {
  let service: KarmicWheelProductService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [KarmicWheelProductService],
    }).compile();

    service = module.get<KarmicWheelProductService>(KarmicWheelProductService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
