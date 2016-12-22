//
//  PNFeedbackViewController.m
//  cfw
//
//  Created by majun on 16/10/19.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNFeedbackViewController.h"
#import "CBTextView.h"
#import "Masonry.h"
#import <YWFeedbackFMWK/YWFeedbackKit.h>
#import "TWMessageBarManager.h"
#import <StoreKit/StoreKit.h>
@interface PNFeedbackViewController ()<SKStoreProductViewControllerDelegate>
@property (strong, nonatomic) CBTextView *textView;
@property (nonatomic,   weak) UINavigationController *weakDetailNavigationController;
@property (nonatomic, strong) YWFeedbackKit *feedbackKit;
@property (nonatomic, assign) YWEnvironment environment;
@property (nonatomic, strong) NSString *appKey;

@end

@implementation PNFeedbackViewController


- (void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithTitle:@"意见反馈"];
    
//    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(pop)];
//    self.navigationItem.leftBarButtonItem = left;
//    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(last)];
//    self.navigationItem.rightBarButtonItems = @[right];
//    
//    self.view.backgroundColor = [UIColor grayColor];
//    _textView = [[CBTextView alloc] init];
//    _textView.placeHolder = @"请输入你的意见和反馈，我们会尽快给你处理！";
//    _textView.placeHolderColor = [UIColor greenColor];
//    [self.view addSubview:_textView];
//    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view).offset(10);
//        make.right.equalTo(self.view).offset(-10);
//        make.top.equalTo(self.view).offset(10);
//        make.height.mas_equalTo(300);
//    }];

    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [image setImage:[UIImage imageNamed:@"feedback1.jpg"]];
    
    [self.view addSubview:image];
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    //    替换成你在阿里百川申请的appkey
    self.appKey = @"23488239";
    self.environment = YWEnvironmentRelease;
    
//    UIButton *feedbackButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    feedbackButton.frame = CGRectMake(100, 150, 300, 50);
//    [self.view addSubview:feedbackButton];
//    [feedbackButton setTitle:@"点击此处留下你的意见反馈" forState:UIControlStateNormal];
//    [feedbackButton addTarget:self action:@selector(actionOpenFeedback) forControlEvents:UIControlEventTouchUpInside];
    
      [self actionOpenFeedback];
}



//SKStoreProductViewController代理方法

-(void)productViewControllerDidFinish:(SKStoreProductViewController*)viewController

{
    
    //返回上一个页面
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -- 调起意见反馈
- (void )actionOpenFeedback{
    self.tabBarController.tabBar.hidden = YES;
    //    替换成你在阿里百川申请的appkey
    self.appKey = @"23488239";
    
    self.feedbackKit = [[YWFeedbackKit alloc] initWithAppKey:self.appKey];
    
    _feedbackKit.environment = self.environment;
    
#warning 设置App自定义扩展反馈数据
    _feedbackKit.extInfo = @{@"loginTime":[[NSDate date] description],
                             @"visitPath":@"登陆->关于->反馈",
                             @"应用自定义扩展信息":@"开发者可以根据需要设置不同的自定义信息，方便在反馈系统中查看"};
#warning 自定义反馈页面配置
    _feedbackKit.customUIPlist = [NSDictionary dictionaryWithObjectsAndKeys:@"/te\'st\\Value1\"", @"testKey1", @"test<script>alert(\"error.yaochen\")</alert>Value2", @"testKey2", nil];
    
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self _openFeedbackViewController];
    });
    
}


#pragma mark 弹出反馈页面
- (void)_openFeedbackViewController
{
    __weak typeof(self) weakSelf = self;
    
    [_feedbackKit makeFeedbackViewControllerWithCompletionBlock:^(YWFeedbackViewController *viewController, NSError *error) {
        if ( viewController != nil ) {
#warning 这里可以设置你需要显示的标题以及nav的leftBarButtonItem，rightBarButtonItem
            viewController.title = @"意见反馈";
            //
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
            
            
            [self.navigationController pushViewController:viewController animated:YES];
            
            viewController.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
            self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
            viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:weakSelf action:@selector(cancelButtonAction)];
            viewController.navigationItem.leftBarButtonItem.tintColor = [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1];
            viewController.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithRed:0.59 green:0.59 blue:0.59 alpha:1],NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:18]};
           // viewController.tabBarController.tabBar.hidden = YES;
            
            
            __weak typeof(nav) weakNav = nav;
            
            [viewController setOpenURLBlock:^(NSString *aURLString, UIViewController *aParentController) {
                UIViewController *webVC = [[UIViewController alloc] initWithNibName:nil bundle:nil];
                UIWebView *webView = [[UIWebView alloc] initWithFrame:webVC.view.bounds];
                webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
                
                [webVC.view addSubview:webView];
                [weakNav pushViewController:webVC animated:YES];
                [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:aURLString]]];
            }];
        } else {
            NSString *title = [error.userInfo objectForKey:@"msg"]?:@"接口调用失败，请保持网络通畅！";
            
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:title description:nil
                                                                  type:TWMessageBarMessageTypeError];
        }
    }];
}

-(void)cancelButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pop{
    
    NSLog(@"点击了取消按钮");
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)last{
    
    NSLog(@"点击了确定按钮");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
