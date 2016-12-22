//
//  PNSettingTableViewController.m
//  cfw
//
//  Created by prism on 16/12/22.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNSettingTableViewController.h"
#import "PNPerfectInfoViewController.h"
#import "PNAboutViewController.h"
#import "PNFeedbackViewController.h"
@interface PNSettingTableViewController ()

@end

@implementation PNSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = NO;
    [self settingGroup];
}
- (void)settingGroup
{
    // 创建组模型
    GPSettingGroup *group = [[GPSettingGroup alloc] init];
    group.items = [NSMutableArray array];
    
//    group.header = @"个人设置";
    NSArray *oneSection = @[@"资料完善",@"用户反馈",@"关于我们"];
    NSArray *imageArray = @[@"xiaoxi",@"jiaoyi",@"jiaoyi"];
    for (int i = 0; i < oneSection.count; i ++) {
        // 创建行模型
        //GPSettingItem *item = [GPSettingArrowItem itemWithTitle:oneSection[i]];
        GPSettingItem *item1 = [GPSettingArrowItem itemWithTitle:oneSection[i] itemWithImage:imageArray[i]];
        item1.operation = ^(NSIndexPath *indexPath){
            
            if (indexPath.row == 0)
            {
                NSLog(@"点击了资料完善");
                PNPerfectInfoViewController *perInfoVC = [[PNPerfectInfoViewController alloc]init];
                [self.navigationController pushViewController:perInfoVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                NSLog(@"点击了用户反馈");
                PNFeedbackViewController *feedbackVC = [[PNFeedbackViewController alloc]init];
                [self.navigationController pushViewController:feedbackVC animated:YES];
            }
            else if (indexPath.row == 2)
            {
                NSLog(@"点击了关于我们");
                PNAboutViewController *feedbackVC = [[PNAboutViewController alloc]init];
                [self.navigationController pushViewController:feedbackVC animated:YES];
            }
        };
        [group.items addObject:item1];
    }
    [self.groups addObject:group];
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
