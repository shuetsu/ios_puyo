//
//  PuyoGesture.h
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/26.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PuyoGestureRecognizer : NSObject
@property (nonatomic, assign)EPuyoGesture gesture;
- (void)touchesBegan:(NSSet*)touches view:(UIView*)view;
- (void)touchesMoved:(NSSet*)touches view:(UIView*)view;
- (void)touchesEnded:(NSSet*)touches view:(UIView*)view;
- (void)doFrame;
@end
