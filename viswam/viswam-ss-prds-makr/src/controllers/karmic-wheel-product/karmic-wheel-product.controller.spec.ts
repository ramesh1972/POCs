import { Test, TestingModule } from '@nestjs/testing';
import { KarmicWheelProductController } from './karmic-wheel-product.controller';
import { KarmicWheelProductService } from './karmic-wheel-product.service';

describe('KarmicWheelProductController', () => {
  let controller: KarmicWheelProductController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [KarmicWheelProductController],
      providers: [KarmicWheelProductService],
    }).compile();

    controller = module.get<KarmicWheelProductController>(
      KarmicWheelProductController,
    );
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
