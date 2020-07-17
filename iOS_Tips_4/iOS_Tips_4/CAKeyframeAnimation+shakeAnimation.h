//
//  CAKeyframeAnimation+shakeAnimation.h
//  iOS_Tips_4
//
//  Created by yuanshi on 2020/7/17.
//  Copyright © 2020 yuanshi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN
// iOS给UITextField添加左右抖动
@interface CAKeyframeAnimation (shakeAnimation)
+ (CAKeyframeAnimation *)shakeAnimation:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
