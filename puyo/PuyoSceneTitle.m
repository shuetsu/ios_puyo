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

@interface linked : NSObject
@property (nonatomic, assign)int count;
@end
@implementation linked
@end

@implementation PuyoSceneTitle

- (id<PuyoScene>)doFrame:(PuyoGame*)game
{
    if (game.gestureRecognizer.gesture == EPuyoGestureTap) {
        [game stageInit];
        return [[PuyoSceneOperation alloc] initWithGame:game];
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
