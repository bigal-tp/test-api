import { Controller, Get, Post, Put, Delete, Body, Param} from '@nestjs/common';
import { CreateBoardgameDto } from './dto/create-boardgame.dto';
import { BoardgamesService } from './boardgames.service';


@Controller('boardgames')
export class BoardgamesController {
    constructor(private boardgamesService: BoardgamesService) {

    }

    @Get()
    findAll() {
        return this.boardgamesService.findAll();
    }   

    

    @Post()
        create(@Body() CreateBoardgameDto: CreateBoardgameDto) {
        //return this.boardgamesService.create(CreateBoardgameDto);
     }
    

}