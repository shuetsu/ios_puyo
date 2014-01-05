//
//  PuyoBackground.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoBackground.h"
#import "PuyoView.h"
#import "PuyoDraw.h"
#import "PuyoGame.h"
#import "PuyoStageMap.h"
#import "PuyoPosition.h"

#define LINE1_SPEED 0.05f
#define LINE2_SPEED 0.04f

@interface PuyoBackground ()
{
    float _phase;
    float _linePhase1;
    float _linePhase2;
}

@end

@implementation PuyoBackground

-(id)init
{
    self = [super init];
    if (self) {
        _phase = 0;
        _linePhase1 = 0;
        _linePhase2 = 0;
        _speed = 0;
        _alert = false;
    }
    return self;
}

- (void)doFrame:(PuyoGame*)game;
{
    _speed = (game.dropSpeed - DROP_SPEED_INITIAL) / (float)(DROP_SPEED_MAX - DROP_SPEED_INITIAL);
    _alert = false;
    for(int r = 0; r < 4; r++) {
        for(int c = 0; c < STAGE_COLS; c++){
            if ([[game.stageMap get:PuyoPositionMake(r, c)] intValue] > EPuyoNone){
                _alert = true;
            }
        }
    }
    _phase += (self.speed + 0.3) * 0.03;
    _linePhase1 += LINE1_SPEED;
    _linePhase2 += LINE2_SPEED;
    if (_phase > M_PI * 2){
        _phase -= M_PI * 2;
    }
    if (_linePhase1 > M_PI * 2){
        _linePhase1 -= M_PI * 2;
    }
    if (_linePhase2 > M_PI * 2){
        _linePhase2 -= M_PI * 2;
    }
}

- (void)draw:(PuyoView*)puyoView
{
    double p = (sin(_phase) + 1.0) * M_PI * 2.0;
    if (!self.alert){
        puyoView.backgroundColor = [UIColor blackColor];
    }else{
        puyoView.backgroundColor = [UIColor colorWithRed:(sin(p * 2) + 1.0f) * 0.25f
                                                   green:0
                                                    blue:0
                                                   alpha:1];
    }
    drawBackgroundLines(p, p + M_PI / 2, _linePhase1, puyoView.bounds);
    drawBackgroundLines(p + M_PI / 2, p, _linePhase2, puyoView.bounds);
}

@end
