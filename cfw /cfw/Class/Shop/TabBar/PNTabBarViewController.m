//
//  PNTabBarViewController.m
//  cfw
//
//  Created by 马军 on 16/9/23.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNTabBarViewController.h"

@interface PNTabBarViewController ()

@end

@implementation PNTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)addViewControllerWithVC:(UIViewController *)vc Title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    [self addViewController:vc Title:title imageName:imageName selectedImageName:selectedImageName];
}
-(void)addViewController:(UIViewController *)viewController Title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    viewController.title=title;
    viewController.tabBarItem.image=[[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
         UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:viewController];
   
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
