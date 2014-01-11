//
//  PuyoSceneDelete.m
//  puyo
//
//  Created by Shuetsu Ito on 2014/01/05.
//  Copyright (c) 2014年 individual. All rights reserved.
//

#import "PuyoSceneDelete.h"
#import "PuyoLib.h"
#import "PuyoDraw.h"
#import "PuyoPosition.h"
#import "PuyoStageMap.h"
#import "PuyoGame.h"
#import "PuyoSceneOperation.h"
#import "PuyoSceneDrop.h"

@interface PuyoLinkCount : NSObject
@property (nonatomic, assign) int count;
@end
@implementation PuyoLinkCount
-(id)init
{
    self = [super init];
    if (self) {
        _count = 0;
    }
    return self;
}
@end

@interface PuyoSceneDelete()
{
    int _chain;
    int _count;
    NSMutableArray *_deletedPuyosPos;
    NSMutableArray *_deletedPuyosType;
}
- (void)deleteLinkedPuyos:(PuyoGame*)game;
- (void)setLinkCount:(PuyoStageMap*)linkCountMap pos:(PuyoPosition*)pos linkCount:(PuyoLinkCount*)linkCount game:(PuyoGame*)game;
@end

@implementation PuyoSceneDelete

- (id)initWithChain:(int)chain
{
    self = [super init];
    if (self) {
        _chain = chain;
        _count = 0;
    }
    return self;
}

-(id<PuyoScene>)begin:(PuyoGame *)game
{
    [self deleteLinkedPuyos:game];
    if (_deletedPuyosPos.count > 0) {
        return self;
    }else{
        return [[[PuyoSceneOperation alloc] init] begin:game];
    }
}

- (void)deleteLinkedPuyos:(PuyoGame*)game
{
    _deletedPuyosPos = [@[] mutableCopy];
    _deletedPuyosType = [@[] mutableCopy];
    PuyoStageMap *linkCountMap = [[PuyoStageMap alloc] initWithDefaultValue:[NSNull null]];
    for (int c = 0; c < STAGE_COLS; c++) {
        for (int r = 0; r < STAGE_ROWS; r++) {
            PuyoPosition *pos = PuyoPositionMake(r, c);
            [self setLinkCount:linkCountMap pos:pos linkCount:[[PuyoLinkCount alloc] init] game:game];
        }
    }
    for (int c = 0; c < STAGE_COLS; c++) {
        for(int r = 0; r < STAGE_ROWS; r++){
            PuyoPosition *pos = PuyoPositionMake(r, c);
            id tmp = [linkCountMap get:pos];
            if (tmp != [NSNull null]){
                PuyoLinkCount *linkCount = tmp;
                if (linkCount.count >= 4) {
                    [_deletedPuyosPos addObject:pos];
                    [_deletedPuyosType addObject:[game.stageMap get:pos]];
                    [game.stageMap put:pos value:@(EPuyoNone)];
                    game.score += (_chain + 1);
                }
            }
        }
    }
}

- (void)setLinkCount:(PuyoStageMap*)linkCountMap pos:(PuyoPosition*)pos linkCount:(PuyoLinkCount*)linkCount game:(PuyoGame*)game
{
    if ([linkCountMap get:pos] != [NSNull null]) {
        return;
    }
    if ([[game.stageMap get:pos] intValue] < EPuyoRed) {
        return;
    }
    [linkCountMap put:pos value:linkCount];
    linkCount.count++;
    {
        PuyoPosition *leftPos = pos.getLeft;
        if ([game.stageMap get:pos] == [game.stageMap get:leftPos]) {
            [self setLinkCount:linkCountMap pos:leftPos linkCount:linkCount game:game];
        }
    }
    {
        PuyoPosition *abovePos = pos.getAbove;
        if ([game.stageMap get:pos] == [game.stageMap get:abovePos]) {
            [self setLinkCount:linkCountMap pos:abovePos linkCount:linkCount game:game];
        }
    }
    {
        PuyoPosition *rightPos = pos.getRight;
        if ([game.stageMap get:pos] == [game.stageMap get:rightPos]) {
            [self setLinkCount:linkCountMap pos:rightPos linkCount:linkCount game:game];
        }
    }
    {
        PuyoPosition *belowPos = pos.getBelow;
        if ([game.stageMap get:pos] == [game.stageMap get:belowPos]) {
            [self setLinkCount:linkCountMap pos:belowPos linkCount:linkCount game:game];
        }
    }
}

-(id<PuyoScene>)doFrame:(PuyoGame *)game
{
    if (_count == 10) {
        return [[PuyoSceneDrop alloc] initWithChain:(_chain + 1)];
    }else{
        _count++;
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
    drawPuyos(game.stageMap, stageRect);
    for (int i = 0; i < _deletedPuyosPos.count; i++) {
        drawPuyoWithAlpha([_deletedPuyosType[i] intValue], getPuyoRect(_deletedPuyosPos[i], stageRect), 0.8 - (_count * 0.08));
    }
}

@end
