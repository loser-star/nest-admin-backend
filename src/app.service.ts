import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
@Injectable()
export class AppService {
  constructor(private configService: ConfigService) {}
  getHello() {
    console.log(this.configService.get<string>('aaa.bbb.ccc'));
    return {
      message: 'Hello World!',
      env: this.configService.get<string>('aaa.bbb.ccc'),
      data: process.env.NODE_ENV,
    };
  }
}
