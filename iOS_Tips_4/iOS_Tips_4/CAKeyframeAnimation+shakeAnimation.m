//
//  CAKeyframeAnimation+shakeAnimation.m
//  iOS_Tips_4
//
//  Created by yuanshi on 2020/7/17.
//  Copyright © 2020 yuanshi. All rights reserved.
//

#import "CAKeyframeAnimation+shakeAnimation.h"

@implementation CAKeyframeAnimation (shakeAnimation)
static int count_shake = 4;     //震动次数
static float duration_shake = 0.5f;   //震动时间
static float vigour_shake = 0.02f;  //震动幅度

+ (CAKeyframeAnimation *)shakeAnimation:(CGRect)frame {
    
    CAKeyframeAnimation *shakeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
  
    CGMutablePathRef shakePath = CGPathCreateMutable();
    CGPathMoveToPoint(shakePath, NULL, CGRectGetMidX(frame), CGRectGetMidY(frame) );
  for (int index = 0; index < count_shake; ++index) {
        
    CGPathAddLineToPoint(shakePath, NULL, CGRectGetMidX(frame) - frame.size.width * vigour_shake,CGRectGetMidY(frame));
    CGPathAddLineToPoint(shakePath, NULL,  CGRectGetMidX(frame) + frame.size.width * vigour_shake,CGRectGetMidY(frame));
  }
    
    CGPathCloseSubpath(shakePath);
    shakeAnimation.path = shakePath;
    shakeAnimation.duration = duration_shake;
    CFRelease(shakePath);
    
    return shakeAnimation;
}
@end
