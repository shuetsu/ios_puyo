//
//  PuyoSceneGameover.m
//  puyo
//
//  Created by Shuetsu Ito on 2014/01/04.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "PuyoSceneGameover.h"
#import "PuyoLib.h"
#import "PuyoDraw.h"
#import "PuyoPosition.h"
#import "PuyoStageMap.h"
#import "PuyoGame.h"
#import "PuyoSceneTitle.h"

@interface PuyoSceneGameover()
{
    int _count;
    int _dropHeight;
    int _dropSpeed;
}
@end

@implementation PuyoSceneGameover

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id<PuyoScene>)doFrame:(PuyoGame *)game
{
    if (_count < 50) {
        _dropHeight += _dropSpeed;
        _dropSpeed++;
        _count++;
        return self;
    }else{
        return [[PuyoSceneTitle alloc] init];
    }
}

- (void)draw:(PuyoView *)puyoView game:(PuyoGame *)game
{
    CGRect viewRect = puyoView.bounds;
    CGRect stageRect = getStageRect(viewRect);
    drawScore(game.score, viewRect);
    drawSideGuard(stageRect);
    for (int c = 0; c < STAGE_COLS; c++) {
        for (int r = 0; r < STAGE_ROWS; r++) {
            PuyoPosition *pos = PuyoPositionMake(r, c);
            drawPuyo([[game.stageMap get:pos] intValue], getPuyoRectWithDrop(pos, stageRect, _dropHeight));
        }
    }
}

@end
