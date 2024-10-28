import { DocumentBuilder } from '@nestjs/swagger';

const swaggerConfig = new DocumentBuilder()
  .setTitle('karmic Wheel Def')
  .setDescription('The karmic Wheel Def APIs description')
  .setVersion('1.0')
  .addTag('Karimc Wheel Def')
  .build();

export default swaggerConfig;
