//
//  PNAboutViewController.m
//  cfw
//
//  Created by 马军 on 16/10/3.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNAboutViewController.h"

@interface PNAboutViewController ()

@end

@implementation PNAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"关于我们"];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [image setImage:[UIImage imageNamed:@"call.jpg"]];
    [self.view addSubview:image];
    
    
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
