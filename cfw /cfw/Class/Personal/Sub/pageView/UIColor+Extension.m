//
//  UIColor+Extension.m
//  QFB
//
//  Created by yl on 2016/11/1.
//  Copyright © 2016年 shujuyun. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)
+(UIColor *)colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b
{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}
+(UIColor *)randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
}
@end
