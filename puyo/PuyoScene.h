//
//  PuyoScene.h
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuyoView.h"
@class PuyoGame;

@protocol PuyoScene <NSObject>
- (id<PuyoScene>)begin:(PuyoGame*)game;
- (id<PuyoScene>)doFrame:(PuyoGame*)game;
- (void)draw:(PuyoView*)puyoView game:(PuyoGame*)game;
@end