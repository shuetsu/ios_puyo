//
//  PuyoSceneOperation.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/30.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoSceneOperation.h"
#import "PuyoGestureRecognizer.h"
#import "PuyoGame.h"
#import "PuyoStageMap.h"
#import "PuyoPosition.h"
#import "PuyoLib.h"
#import "PuyoDraw.h"
#import "PuyoSceneDrop.h"

@interface PuyoSceneOperation()
{
    PuyoPosition *_puyoPos1;
    PuyoPosition *_puyoPos2;
    EPuyoType _puyoType1;
    EPuyoType _puyoType2;
    EPuyoRoll _puyoRoll;
    int _dropDelay;
}
- (bool)updatePuyoPos:(PuyoPosition*)puyoPos roll:(EPuyoRoll)puyoRoll stageMap:(PuyoStageMap*)stageMap;
- (bool)dropPuyo:(PuyoGame*)game;
@end

@implementation PuyoSceneOperation

- (id)initWithGame:(PuyoGame *)game
{
    self = [super init];
    if (self){
        _puyoType1 = (arc4random() % 4) + EPuyoRed;
        _puyoType2 = (arc4random() % 4) + EPuyoRed;
        _puyoPos1 = PuyoPositionMake(0, 2);
        _puyoPos2 = [_puyoPos1 getAbove];
        _puyoRoll = EPuyoRollAbove;
        _dropDelay = DROP_DELAY;
    }
    return self;
}

- (id<PuyoScene>)doFrame:(PuyoGame *)game
{
    if (game.gestureRecognizer.gesture == EPuyoGestureTap) {
        [self updatePuyoPos:_puyoPos1 roll:(_puyoRoll + 1) % 4 stageMap:game.stageMap];
    }else if (game.gestureRecognizer.gesture == EPuyoGestureSwipeLeft){
        [self updatePuyoPos:[_puyoPos1 getLeft] roll:_puyoRoll stageMap:game.stageMap];
    }else if (game.gestureRecognizer.gesture == EPuyoGestureSwipeRight){
        [self updatePuyoPos:[_puyoPos1 getRight] roll:_puyoRoll stageMap:game.stageMap];
    }else if (game.gestureRecognizer.gesture == EPuyoGestureSwipeBelow){
        while ([self dropPuyo:game]) {}
        return [[PuyoSceneDrop alloc] initWithGame:game chain:0];
    }
    if (_dropDelay <= 0){
        if (![self dropPuyo:game]) {
            return [[PuyoSceneDrop alloc] initWithGame:game chain:0];
        }
        _dropDelay += DROP_DELAY;
    }else{
        _dropDelay -= game.dropSpeed;
    }
    return self;
}

- (bool)dropPuyo:(PuyoGame*)game
{
    if ([self updatePuyoPos:[_puyoPos1 getBelow] roll:_puyoRoll stageMap:game.stageMap]) {
        return true;
    }else{
        [game.stageMap put:_puyoPos1 value:@(_puyoType1)];
        [game.stageMap put:_puyoPos2 value:@(_puyoType2)];
        return false;
    }
}

- (bool)updatePuyoPos:(PuyoPosition *)puyoPos roll:(EPuyoRoll)puyoRoll stageMap:(PuyoStageMap *)stageMap
{
    PuyoPosition *puyoPos1 = puyoPos;
    PuyoPosition *puyoPos2;
    switch (puyoRoll) {
    case EPuyoRollAbove:
        puyoPos2 = [puyoPos1 getAbove];
        break;
    case EPuyoRollRight:
        puyoPos2 = [puyoPos1 getRight];
        break;
    case EPuyoRollBelow:
        puyoPos2 = [puyoPos1 getBelow];
        break;
    case EPuyoRollLeft:
        puyoPos2 = [puyoPos1 getLeft];
        break;
    }
    if (puyoPos1.row >= STAGE_ROWS ||
        puyoPos2.row >= STAGE_ROWS ||
        puyoPos1.col < 0 || puyoPos1.col >= STAGE_COLS ||
        puyoPos2.col < 0 || puyoPos2.col >= STAGE_COLS) {
        return false;
    }
    if ([[stageMap get:puyoPos1] integerValue] != EPuyoNone){
        return false;
    }
    if ([[stageMap get:puyoPos2] integerValue] != EPuyoNone){
        return false;
    }
    _puyoPos1 = puyoPos1;
    _puyoPos2 = puyoPos2;
    _puyoRoll = puyoRoll;
    return true;
}

- (void)draw:(PuyoView *)puyoView game:(PuyoGame *)game
{
    CGRect viewRect = puyoView.bounds;
    CGRect stageRect = getStageRect(viewRect);
    drawScore(game.score, viewRect);
    drawSideGuard(stageRect);
    drawBottomGuard(stageRect);
    drawPuyos(game.stageMap, stageRect);
    drawPuyo(_puyoType1, getPuyoRect(_puyoPos1, stageRect));
    drawPuyo(_puyoType2, getPuyoRect(_puyoPos2, stageRect));
}

@end
