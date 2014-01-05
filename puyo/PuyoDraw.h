//
//  PuyoDraw.h
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PuyoGame;
@class PuyoPosition;
@class PuyoStageMap;

void drawBackgroundLines(double phase0, double phase1, double phase2, CGRect viewRect);
void drawSideGuard(CGRect stageRect);
void drawBottomGuard(CGRect stageRect);
void drawPuyo(EPuyoType puyoType, CGRect puyoRect);
void drawPuyoWithAlpha(EPuyoType puyoType, CGRect puyoRect, float alpha);
void drawPuyos(PuyoStageMap *stageMap, CGRect stageRect);
void drawScore(int score, CGRect viewRect);
void drawTitle(int score, CGRect viewRect);
NSDictionary* centerAttrs();
NSDictionary* leftAttrs();