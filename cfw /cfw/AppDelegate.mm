//
//  AppDelegate.m
//  cfw
//
//  Created by 马军 on 16/9/23.
//  Copyright © 2016年 马军. All rights reserved.
//



#import "AppDelegate.h"
#import "PNMapViewController.h"
#import "PNShopViewController.h"
#import "PNPersonalViewController.h"
#import "PNMyTableViewController.h"
//#import "PNAutoLoginViewController.h"
//#import "PNRegisterViewController.h"
#import "RegistrationVC.h"
#import "PNChatViewController.h"
#import "PNViewDetailController.h" // 商城
@interface AppDelegate ()<EMChatManagerDelegate>


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];    application.statusBarHidden =NO;
    
//    PNAutoLoginViewController *autoLoginVC = [[PNAutoLoginViewController alloc]init];
//    self.window.rootViewController = autoLoginVC;
    
    
//    PNRegisterViewController *Rvc = [[PNRegisterViewController alloc]init];
//    self.window.rootViewController = Rvc;

    
    
    
    
    RegistrationVC *rvc = [[RegistrationVC alloc]init];
    self.window.rootViewController = rvc;

    
    
    [self setUpTarBar];
    [self setUpBaiduMap];
    [self.window makeKeyAndVisible];
    
    
    EMOptions *options = [EMOptions optionsWithAppkey:@"1194161226178223#caifengwang"];
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    return YES;
}


// 发送一个下线消息

- (void)sendSignOutMsg{
    
#pragma mark  发送一个下线状态
    
    // 取出name
    
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults]objectForKey:@"ResultAuthData"];
    
    NSLog(@"%@",dic);
    
    if (dic) {
        
        NSString *name = [dic objectForKey:@"name"];
        
        // 取出uid
        NSString *uid = [dic objectForKey:@"uid"];
        
        
        NSDictionary *resultDiction = [NSDictionary dictionaryWithObjectsAndKeys:@"0",@"status",uid,@"uid",name,@"name", nil];
        
        [[NSUserDefaults standardUserDefaults] setObject:resultDiction forKey:@"ResultAuthData"];
        //保存数据，实现持久化存储
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
        
#pragma mark 返回给后台一个json数据
        
        NSString *urlString = @"http://192.168.0.169:8080/miningbee-web/ws/userStatus/status";
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        
        // 2.设置请求头
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        // 3.设置请求体
        NSDictionary *json = @{
                               @"uid":uid,
                               @"status" : @"0",
                               };
        
        //    NSData --> NSDictionary
        // NSDictionary --> NSData
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:NSJSONReadingAllowFragments error:nil];
        request.HTTPBody = data;
        NSLog(@"%lu", (unsigned long)data.length);
        
        // 4.发送请求
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSLog(@"%lu", (unsigned long)data.length);
            
            NSLog(@"%@",connectionError);
            NSLog(@"用户推出了app！！");
        }];
        
        
    }
    

}

- (void)sendLoginMsg{
    
}

- (void)setUpTarBar{

    self.tabBarVC=[[PNTabBarViewController alloc]init];
    //添加自视图控制器
    PNMapViewController *map=[[PNMapViewController alloc]init];
//    PNShopViewController *shop=[[PNShopViewController alloc]init];
   // PNPersonalViewController *personal=[[PNPersonalViewController alloc]init];
    
    
    // 商城VC
    PNViewDetailController *shop = [[PNViewDetailController alloc]init];
    PNChatViewController *chat = [[PNChatViewController alloc]init];
    
    PNMyTableViewController *my = [[PNMyTableViewController alloc]init];
    [self.tabBarVC addViewControllerWithVC:map Title:@"地图" imageName:@"item_map_off" selectedImageName:@"item_map_on"];
    [self.tabBarVC addViewControllerWithVC:shop Title:@"商城" imageName:@"item_store_off" selectedImageName:@"item_store_on"];
    [self.tabBarVC addViewControllerWithVC:chat Title:@"通讯" imageName:@"item_chat_off" selectedImageName:@"item_chat_on"];
    
    [self.tabBarVC addViewControllerWithVC:my Title:@"服务" imageName:@"item_user_off" selectedImageName:@"item_user_on"];
    self.window.rootViewController=self.tabBarVC;
  
    
    //初始化应用，appKey和appSecret从后台申请得
    [SMSSDK registerApp:@"17ab085b4f333"
             withSecret:@"db2052229e318f242c63c0f2e4871367"];
   
  

}

- (void)setUpBaiduMap{
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"b3uW1xe5ddKIGDjCsTzA469vzZiidthL"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
}


- (void)messagesDidReceive:(NSArray *)aMessages
{
    NSLog(@"124156");
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
 
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self sendSignOutMsg];
}

@end
