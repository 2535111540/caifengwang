//
//  PNBaseViewController.h
//  cfw
//
//  Created by 马军 on 16/9/23.
//  Copyright © 2016年 马军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNBaseViewController : UIViewController

// 设置标题
- (void)addTitleViewWithTitle:(NSString *)title ;
// 设置左右按钮
- (void)addBarButtonItem:(NSString *)name image:(UIImage *) image target:(id)target action:(SEL)action isLeft:(BOOL)isLeft;
@end
