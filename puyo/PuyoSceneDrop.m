//
//  PuyoSceneDrop.m
//  puyo
//
//  Created by Shuetsu Ito on 2014/01/03.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "PuyoSceneDrop.h"
#import "PuyoLib.h"
#import "PuyoDraw.h"
#import "PuyoGame.h"
#import "PuyoStageMap.h"
#import "PuyoPosition.h"
#import "PuyoSceneDelete.h"

@interface PuyoSceneDrop()
{
    int _chain;
    int _dropHeight;
    int _dropSpeed;
    PuyoStageMap *_dropMap;
}
- (int)dropHeightLimit:(PuyoPosition*)pos;
- (bool)dropped;
- (void)updateStageMap:(PuyoGame*)game;
@end

@implementation PuyoSceneDrop

- (id)initWithGame:(PuyoGame *)game chain:(int)chain
{
    self = [super init];
    if (self) {
        _chain = chain;
        _dropHeight = 0;
        _dropSpeed = 0;
        _dropMap = [[PuyoStageMap alloc] initWithDefaultValue:@(0)];
        for (int c = 0; c < STAGE_COLS; c++) {
            int drop = 0;
            for(int r = STAGE_ROWS - 1; r >= 0; r--){
                PuyoPosition *pos = PuyoPositionMake(r, c);
                [_dropMap put:pos value:@(drop)];
                if ([[game.stageMap get:pos] integerValue] == EPuyoNone) {
                    drop++;
                }
            }
        }
    }
    return self;
}

- (id<PuyoScene>)doFrame:(PuyoGame *)game
{
    _dropHeight += _dropSpeed;
    _dropSpeed++;
    if ([self dropped]) {
        [self updateStageMap:game];
        return [[PuyoSceneDelete alloc] initWithGame:game chain:_chain];
    }else{
        return self;
    }
}

- (void)draw:(PuyoView *)puyoView game:(PuyoGame *)game
{
    CGRect viewRect = puyoView.bounds;
    CGRect stageRect = getStageRect(viewRect);
    drawScore(game.score, viewRect);
    drawSideGuard(stageRect);
    drawBottomGuard(stageRect);
    for (int c = 0; c < STAGE_COLS; c++) {
        for (int r = 0; r < STAGE_ROWS; r++) {
            PuyoPosition *pos = PuyoPositionMake(r, c);
            int limit = [self dropHeightLimit:pos];
            drawPuyo([[game.stageMap get:pos] intValue], getPuyoRectWithDrop(pos, stageRect, (_dropHeight < limit ? _dropHeight : limit)));
        }
    }
}

- (int)dropHeightLimit:(PuyoPosition *)pos
{
    return [[_dropMap get:pos] intValue] * PUYO_H;
}

- (bool)dropped
{
    for (int c = 0; c < STAGE_COLS; c++) {
        for (int r = 0; r < STAGE_ROWS; r++) {
            PuyoPosition *pos = PuyoPositionMake(r, c);
            int limit = [self dropHeightLimit:pos];
            if (_dropHeight < limit) {
                return false;
            }
        }
    }
    return true;
}

- (void)updateStageMap:(PuyoGame *)game
{
    PuyoStageMap *stageMap = [[PuyoStageMap alloc] initWithDefaultValue:@(EPuyoNone)];
    for (int c = 0; c < STAGE_COLS; c++) {
        for (int r = STAGE_ROWS - 1; r >= 0; r--) {
            PuyoPosition *fromPos = PuyoPositionMake(r, c);
            PuyoPosition *toPos = PuyoPositionMake(r + [[_dropMap get:fromPos] intValue], c);
            [stageMap put:toPos value:[game.stageMap get:fromPos]];
        }
    }
    game.stageMap = stageMap;
}

@end