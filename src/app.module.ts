import { Module, HttpModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { BoardgamesController } from "./boardgames/Boardgames.Controller";
import { BoardgamesService } from './boardgames/Boardgames.Service';
//import { BoardgamesModule } from './boardgames/boardgames.module';
//import config from './boardgames/config/keys';

@Module({
  imports: [HttpModule] ,
  controllers: [AppController, BoardgamesController],
  providers: [AppService, BoardgamesService],
})
export class AppModule {}
