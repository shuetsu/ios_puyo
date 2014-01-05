//
//  PuyoGesture.m
//  puyo
//
//  Created by Shuetsu Ito on 2013/12/26.
//  Copyright (c) 2013年 individual. All rights reserved.
//

#import "PuyoGestureRecognizer.h"

@interface PuyoGestureRecognizer()
{
    CGPoint _lastLocation;
    bool _swiped;
    bool _swipeBelowHandled;
}
@end

@implementation PuyoGestureRecognizer

- (id)init
{
    self = [super init];
    if (self) {
        _lastLocation = CGPointMake(0, 0);
        _swiped = false;
        _swipeBelowHandled = false;
        _gesture = EPuyoGestureNone;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches view:(UIView *)view
{
    UITouch *touch = [touches anyObject];
    _lastLocation = [touch locationInView:view];
    _swiped = false;
    _swipeBelowHandled = false;
}

- (void)touchesMoved:(NSSet *)touches view:(UIView *)view
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:view];
    if (location.x <= _lastLocation.x - PUYO_W) {
        _gesture = EPuyoGestureSwipeLeft;
        _lastLocation = location;
        _swiped = true;
    }else if (location.x >= _lastLocation.x + PUYO_W){
        _gesture = EPuyoGestureSwipeRight;
        _lastLocation = location;
        _swiped = true;
    }else if (location.y >= _lastLocation.y + PUYO_H && !_swipeBelowHandled){
        _gesture = EPuyoGestureSwipeBelow;
        _lastLocation = location;
        _swiped = true;
        _swipeBelowHandled = true;
    }
}

- (void)touchesEnded:(NSSet *)touches view:(UIView *)view
{
    if (!_swiped) {
        _gesture = EPuyoGestureTap;
    }
}

- (void)doFrame
{
    _gesture = EPuyoGestureNone;
}

@end
