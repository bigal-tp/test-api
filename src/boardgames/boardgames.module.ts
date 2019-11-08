import { Module, HttpService } from '@nestjs/common';
import { BoardgamesController } from "./Boardgames.Controller";
import { BoardgamesService } from './Boardgames.Service';

@Module({
  imports: [],
  controllers: [BoardgamesController],
  providers: [BoardgamesService],
})
export class BoardgamesModule {}