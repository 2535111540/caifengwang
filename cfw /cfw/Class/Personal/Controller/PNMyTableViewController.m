//
//  PNMyTableViewController.m
//  cfw
//
//  Created by 马军 on 16/9/26.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNMyTableViewController.h"
#import "PNMyHeadView.h"
#import "GPSettingItem.h"
#import "RegistrationVC.h"
#import "PNAutoLoginViewController.h"
//#import "PNAboutViewController.h"
#import "PNPerfectInfoViewController.h"
#import "PNFeedbackViewController.h"
#import "PNSettingTableViewController.h"
#import "PNSetupShopViewController.h"
#import "RegistrationVC.h"
#import "PNQualityTestingViewController.h"
@interface PNMyTableViewController ()
{
    UIButton *SignOutBtn;
}
@end

@implementation PNMyTableViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
   
     self.tabBarController.tabBar.hidden = NO;
    
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"ResultAuthData"];
    
    NSString *result = [dic objectForKey:@"status"];
    
    NSLog(@"------------%@",result);
    
    if ([result isEqualToString:@"1"]) {
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"已登陆" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
        self.navigationItem.rightBarButtonItem = rightItem;
        [SignOutBtn setTitle:@"退出" forState:UIControlStateNormal]; // 设置退出按钮的状态
    }else if([result isEqualToString:@"0"]){
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
        self.navigationItem.rightBarButtonItem = rightItem;
        [SignOutBtn setTitle:@"请登录" forState:UIControlStateNormal];
        
        
    }

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"服务";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = NO;
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self setUpHeadView];
    [self setUpGroup0];
    [self setUpFootView];
    
    
}

- (void)rightAction{
    NSLog(@"点击了右baritem");
    
//    RegistrationVC *regVC = [[RegistrationVC alloc]init];
//    // [self setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:regVC animated:YES];
    
    PNAutoLoginViewController *autoLoginVC = [[PNAutoLoginViewController alloc]init];
    [self presentViewController:autoLoginVC animated:YES completion:nil];
    
}

- (void)setUpHeadView{
    
    
    
    PNMyHeadView *headView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PNMyHeadView class]) owner:nil options:nil].lastObject;
    headView.frame = CGRectMake(0, 0,self.view.bounds.size.width, 70);
    self.tableView.tableHeaderView = headView;

}

- (void)setUpGroup0{
    // 创建组模型
    GPSettingGroup *group = [[GPSettingGroup alloc] init];
    group.items = [NSMutableArray array];
    
    group.header = @"个人设置";
    NSArray *oneSection = @[@"开店审核",@"专家问诊",@"技术帮助",@"质检审核",@"设置"];
    NSArray *imageArray = @[@"xiaoxi",@"jiaoyi",@"shenfen",@"fankui",@"guanyu"];
    for (int i = 0; i < oneSection.count; i ++) {
        // 创建行模型
        //GPSettingItem *item = [GPSettingArrowItem itemWithTitle:oneSection[i]];
        GPSettingItem *item1 = [GPSettingArrowItem itemWithTitle:oneSection[i] itemWithImage:imageArray[i]];
        item1.operation = ^(NSIndexPath *indexPath){
            
            if (indexPath.row == 0)
            {
                PNSetupShopViewController *setShopVC = [[PNSetupShopViewController alloc]init];
                [self.navigationController pushViewController:setShopVC animated:YES];
            }
            else if (indexPath.row == 1)
            {
                NSLog(@"点击了专家问诊");
            }
            else if (indexPath.row == 2)
            {
                NSLog(@"点击了技术支持");
            }
            else if (indexPath.row == 3)
            {
                PNQualityTestingViewController *qTestVC = [[PNQualityTestingViewController alloc]init];
                [self.navigationController pushViewController:qTestVC animated:YES];
                
            }
            else if (indexPath.row == 4)
            {
                NSLog(@"设置界面");
                PNSettingTableViewController *aboutVC = [[PNSettingTableViewController alloc]init];
                [self.navigationController pushViewController:aboutVC animated:NO];
            }
            
        };
        [group.items addObject:item1];
    }
    [self.groups addObject:group];

}


- (void)setUpFootView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
     SignOutBtn = [[UIButton alloc]init];
     SignOutBtn.frame = CGRectMake(0, 0,self.view.bounds.size.width,50);
     SignOutBtn.backgroundColor = [UIColor grayColor];
    [SignOutBtn setTitle:@"退出" forState:UIControlStateNormal];
    [SignOutBtn addTarget:self action:@selector(signOut:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:SignOutBtn];
    
    self.tableView.tableFooterView = view;
}

- (void)signOut:(UIButton *)btn{
    NSLog(@"点击了退出按钮");
    
    


    PNAutoLoginViewController *autoLoginVC = [[PNAutoLoginViewController alloc]init];
    
//    RegistrationVC *registrVC = [[RegistrationVC alloc]init];
    
    
    
    
    
    
//#pragma mark  发送一个下线状态
//    
//    // 取出name
//    
//    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"ResultAuthData"];
//    
//    NSLog(@"%@",dic);
//    
//    if (dic) {
//        
//        NSString *name = [dic objectForKey:@"name"];
//        
//        // 取出uid
//        NSString *uid = [dic objectForKey:@"uid"];
//        
//        
//        NSDictionary *resultDiction = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"status",uid,@"uid",name,@"name", nil];
//        
//        [[NSUserDefaults standardUserDefaults] setObject:resultDiction forKey:@"ResultAuthData"];
//        //保存数据，实现持久化存储
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        
//        
//        
//#pragma mark 返回给后台一个json数据
//        
//        NSString *urlString = @"http://192.168.0.169:8080/miningbee-web/ws/userStatus/status";
//        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//        request.HTTPMethod = @"POST";
//        
//        // 2.设置请求头
//        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        
//        // 3.设置请求体
//        NSDictionary *json = @{
//                               @"uid":uid,
//                               @"status" : @"0",
//                               };
//        
//        //    NSData --> NSDictionary
//        // NSDictionary --> NSData
//        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONReadingAllowFragments error:nil];
//        request.HTTPBody = data;
//        NSLog(@"%lu", (unsigned long)data.length);
//        
//        // 4.发送请求
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            NSLog(@"%lu", (unsigned long)data.length);
//            
//            NSLog(@"%@",connectionError);
//            NSLog(@"用户下线了！！");
//        }];
//        
//        
//    }
//    
//
//
    
     [self presentViewController:autoLoginVC animated:YES completion:^{
         
     }];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
