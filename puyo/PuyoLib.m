//
//  PuyoLib.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/25.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoLib.h"
#import "PuyoPosition.h"

CGRect getStageRect(CGRect viewRect)
{
    int w = PUYO_W * STAGE_COLS;
    int h = PUYO_H * STAGE_ROWS;
    return CGRectMake(viewRect.origin.x + (viewRect.size.width - w) / 2,
                      viewRect.origin.y + (viewRect.size.height - h) / 2,
                      w, h);
}

CGRect getPuyoRect(PuyoPosition *pos, CGRect stageRect)
{
    return getPuyoRectWithDrop(pos, stageRect, 0);
}

CGRect getPuyoRectWithDrop(PuyoPosition *pos, CGRect stageRect, int dropHeight)
{
    return CGRectMake(stageRect.origin.x + pos.col * PUYO_W + 1,
                      stageRect.origin.y + pos.row * PUYO_H + 1 + dropHeight,
                      PUYO_W - 2,
                      PUYO_H - 2);
}