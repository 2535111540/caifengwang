//
//  PNBaseViewController.m
//  cfw
//
//  Created by 马军 on 16/9/23.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNBaseViewController.h"

@interface PNBaseViewController ()

@end

@implementation PNBaseViewController

+ (void)initialize{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:[UIColor orangeColor]];
    navBar.titleTextAttributes=@{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)addTitleViewWithTitle:(NSString *)title
{
    UILabel * titleView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    self.navigationItem.titleView = titleView;
//    // 设置字体
    titleView.font =  [UIFont fontWithName:@"Helvetica" size:18];
//    // 设置颜色
//    titleView.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    titleView.textColor = [UIColor whiteColor];
    // 设置文字居中
    titleView.textAlignment = NSTextAlignmentCenter;
    // 设置文本
    titleView.text = title;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];    
    
}

- (void)addBarButtonItem:(NSString *)name image:(UIImage *)image target:(id)target action:(SEL)action isLeft:(BOOL)isLeft
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    // 设置按钮
    [button setTitle:name forState:UIControlStateNormal];
    // 设置图片
    [button setBackgroundImage:image forState:UIControlStateNormal];
    // 设置frame
    button.frame = CGRectMake(0, 0, 44, 30);
    
    // 判断是否放在左侧按钮
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    }
    else {
        self.navigationItem.rightBarButtonItem = item;
    }
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
