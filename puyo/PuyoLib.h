//
//  PuyoLib.h
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/25.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PuyoPosition;

CGRect getStageRect(CGRect viewRect);
CGRect getPuyoRect(PuyoPosition *pos, CGRect stageRect);
CGRect getPuyoRectWithDrop(PuyoPosition *pos, CGRect stageRect, int dropHeight);