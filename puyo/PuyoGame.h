//
//  PuyoGame.h
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PuyoScene.h"
@class PuyoStageMap;
@class PuyoView;
@class PuyoGestureRecognizer;

@interface PuyoGame : NSObject
@property (nonatomic, strong)PuyoGestureRecognizer *gestureRecognizer;
@property (nonatomic, strong)PuyoStageMap *stageMap;
@property (nonatomic, assign)int score;
@property (nonatomic, assign)int dropSpeed;
- (void)doFrame;
- (void)draw:(PuyoView *)puyoView;
- (void)stageInit;
@end
