//
//  PuyoGame.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoGame.h"
#import "PuyoGestureRecognizer.h"
#import "PuyoBackground.h"
#import "PuyoView.h"
#import "PuyoStageMap.h"
#import "PuyoSceneTitle.h"

@interface PuyoGame()
{
    id<PuyoScene> _nextScene;
    id<PuyoScene> _scene;
    PuyoBackground *_background;
    
}
@end

@implementation PuyoGame

- (id)init
{
    self = [super init];
    if (self){
        _gestureRecognizer = [[PuyoGestureRecognizer alloc] init];
        _nextScene = [[PuyoSceneTitle alloc] init];
        _background = [[PuyoBackground alloc] init];
        [self stageInit];
    }
    return self;
}

- (void)doFrame
{
    if (_nextScene != _scene) {
        _scene = [_nextScene begin:self];
    }
    _nextScene = [_scene doFrame:self];
    [_background doFrame:self];
    [_gestureRecognizer doFrame];
}

- (void)draw:(PuyoView*)puyoView
{
    [_background draw:puyoView];
    [_scene draw:puyoView game:self];
}

- (void)stageInit
{
    _stageMap = [[PuyoStageMap alloc] initWithDefaultValue:@(EPuyoNone)];
    _score = 0;
    _dropSpeed = DROP_SPEED_INITIAL;
}

@end
