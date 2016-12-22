//
//  PNTabBarViewController.h
//  cfw
//
//  Created by 马军 on 16/9/23.
//  Copyright © 2016年 马军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PNTabBarViewController : UITabBarController

-(void)addViewControllerWithVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;

@end
