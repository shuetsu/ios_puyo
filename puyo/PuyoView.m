//
//  PuyoView.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoView.h"
#import "PuyoGame.h"

@implementation PuyoView

- (id)initWithFrame:(CGRect)frame game:(PuyoGame*)game
{
    self = [super initWithFrame:frame];
    if (self) {
        _game = game;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self.game draw:self];
}

@end
