//
//  PuyoDraw.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/24.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoDraw.h"
#import "PuyoLib.h"
#import "PuyoGame.h"
#import "PuyoStageMap.h"
#import "PuyoPosition.h"

void drawBackgroundLines(double phase0, double phase1, double phase2, CGRect rect){
    double l0 = (rect.size.height > rect.size.width ?
                 rect.size.height : rect.size.width);
    CGPoint center = CGPointMake(rect.origin.x + rect.size.width / 2,
                                 rect.origin.y + rect.size.height / 2);
    [[UIColor greenColor] setStroke];
    {
        double dx0 = cos(phase0);
        double dy0 = sin(phase0);
        double dx1 = cos(phase1);
        double dy1 = sin(phase1);
        double dl1 = (sin(phase2) + 1.0) * 60 + 20;
        double l1 = dl1 / 2;
        while(l1 < l0){
            UIBezierPath *path1 = [UIBezierPath bezierPath];
            [path1 moveToPoint:CGPointMake(center.x + dx0 * l0 + dx1 * l1,
                                           center.y + dy0 * l0 + dy1 * l1)];
            [path1 addLineToPoint:CGPointMake(center.x - dx0 * l0 + dx1 * l1,
                                              center.y - dy0 * l0 + dy1 * l1)];
            [path1 stroke];
            UIBezierPath *path2 = [UIBezierPath bezierPath];
            [path2 moveToPoint:CGPointMake(center.x + dx0 * l0 - dx1 * l1,
                                           center.y + dy0 * l0 - dy1 * l1)];
            [path2 addLineToPoint:CGPointMake(center.x - dx0 * l0 - dx1 * l1,
                                              center.y - dy0 * l0 - dy1 * l1)];
            [path2 stroke];
            l1 += dl1;
        }
    }
}

void drawSideGuard(CGRect stageRect)
{
    [[UIColor colorWithWhite:1 alpha:0.5] setStroke];
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(stageRect.origin.x - 2,
                                   stageRect.origin.y)];
    [path1 addLineToPoint:CGPointMake(stageRect.origin.x - 2,
                                      stageRect.origin.y + stageRect.size.height)];
    [path1 setLineWidth:5.0];
    [path1 stroke];
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(stageRect.origin.x + stageRect.size.width + 2,
                                   stageRect.origin.y)];
    [path2 addLineToPoint:CGPointMake(stageRect.origin.x + stageRect.size.width + 2,
                                      stageRect.origin.y + stageRect.size.height)];
    [path2 setLineWidth:5.0];
    [path2 stroke];

}

void drawBottomGuard(CGRect stageRect)
{
    [[UIColor colorWithWhite:1 alpha:0.5] setStroke];
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(stageRect.origin.x,
                                  stageRect.origin.y + stageRect.size.height + 2)];
    [path addLineToPoint:CGPointMake(stageRect.origin.x + stageRect.size.width,
                                     stageRect.origin.y + stageRect.size.height + 2)];
    [path setLineWidth:5.0];
    [path stroke];
}

void drawPuyo(EPuyoType puyoType, CGRect puyoRect){
    drawPuyoWithAlpha(puyoType, puyoRect, 0.8);
}

void drawPuyoWithAlpha(EPuyoType puyoType, CGRect puyoRect, float alpha){
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:puyoRect];
    if (puyoType == EPuyoNone) {
        return;
    }
    [path setLineWidth:2.0];
    [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:alpha] setStroke];
    switch(puyoType) {
        case EPuyoRed:
            [[UIColor colorWithRed:1.0 green:0.3 blue:0.3 alpha:alpha] setFill];
            break;
        case EPuyoBlue:
            [[UIColor colorWithRed:0.3 green:0.3 blue:1.0 alpha:alpha] setFill];
            break;
        case EPuyoGreen:
            [[UIColor colorWithRed:0.5 green:1.0 blue:0.3 alpha:alpha] setFill];
            break;
        case EPuyoYellow:
            [[UIColor colorWithRed:1.0 green:1.0 blue:0.3 alpha:alpha] setFill];
            break;
        default:
            break;
    }
    [path fill];
    [path stroke];
}

void drawPuyos(PuyoStageMap *stageMap, CGRect stageRect){
    for(int r = 0;r < STAGE_ROWS;r++){
        for(int c = 0;c < STAGE_COLS;c++){
            PuyoPosition *pos = PuyoPositionMake(r, c);
            EPuyoType puyoType = [[stageMap get:pos] integerValue];
            drawPuyo(puyoType, getPuyoRect(pos, stageRect));
        }
    }
}

void drawScore(int score, CGRect viewRect)
{
    [[NSString stringWithFormat:@"%05d", score]
    drawAtPoint:CGPointMake(viewRect.origin.x + 5,
                            viewRect.origin.y + 5)
                 withAttributes:leftAttrs()];
}

void drawTitle(int score, CGRect viewRect)
{
    [@"game over"
     drawInRect:CGRectMake(viewRect.origin.x,
                           viewRect.origin.y + viewRect.size.height / 2 - 50,
                           viewRect.size.width,
                           30)
     withAttributes:centerAttrs()];
    if (score > 0) {
        [[NSString stringWithFormat:@"%d", score]
         drawInRect:CGRectMake(viewRect.origin.x,
                               viewRect.origin.y + viewRect.size.height / 2 - 10,
                               viewRect.size.width,
                               30)
         withAttributes:centerAttrs()];
    }
    [@"tap to start"
     drawInRect:CGRectMake(viewRect.origin.x,
                           viewRect.origin.y + viewRect.size.height / 2 + 70,
                           viewRect.size.width,
                           30)
     withAttributes:centerAttrs()];

}

NSDictionary* centerAttrs()
{
    [[UIColor whiteColor] set];
    NSMutableParagraphStyle *p = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [p setAlignment:NSTextAlignmentCenter];
    return @{NSForegroundColorAttributeName: [UIColor whiteColor],
             NSFontAttributeName: [UIFont systemFontOfSize:20.0f],
             NSParagraphStyleAttributeName: p};
    
}

NSDictionary* leftAttrs()
{
    return @{NSForegroundColorAttributeName: [UIColor whiteColor],
             NSFontAttributeName: [UIFont systemFontOfSize:20.0f]};
}