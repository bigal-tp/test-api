import { Injectable, HttpService, Body } from '@nestjs/common';
import { map } from 'rxjs/operators';

@Injectable()
export class BoardgamesService {
    
    constructor(private http: HttpService){

    }

    findAll(){
        return this.http.get('http://localhost:8500/boardgames.cfc?method=findAll')
            .pipe(
                map(response => response.data)
            );
    }
    
    create(CreateBoardgameDto){
        return this.http.post('http://localhost:8500/boardgames.cfc?method=post',{
            name: CreateBoardgameDto.name,
            descritpion: CreateBoardgameDto.descritpion,
            rating: CreateBoardgameDto.rating
        })   
    }
}