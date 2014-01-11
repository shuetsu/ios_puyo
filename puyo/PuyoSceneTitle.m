//
//  PuyoSceneTitle.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoSceneTitle.h"
#import "PuyoGestureRecognizer.h"
#import "PuyoLib.h"
#import "PuyoGame.h"
#import "PuyoDraw.h"
#import "PuyoPosition.h"
#import "PuyoSceneOperation.h"

@implementation PuyoSceneTitle

- (id<PuyoScene>)begin:(PuyoGame *)game
{
    return self;
}

- (id<PuyoScene>)doFrame:(PuyoGame*)game
{
    if (game.gestureRecognizer.gesture == EPuyoGestureTap) {
        [game stageInit];
        return [[PuyoSceneOperation alloc] init];
    }else{
        return self;
    }
}

- (void)draw:(PuyoView*)puyoView game:(PuyoGame*)game
{
    CGRect viewRect = puyoView.bounds;
    CGRect stageRect = getStageRect(viewRect);
    drawSideGuard(stageRect);
    drawTitle(game.score, viewRect);
}

@end
