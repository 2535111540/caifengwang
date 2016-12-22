//
//  PNShopViewController.m
//  cfw
//
//  Created by 马军 on 16/9/23.
//  Copyright © 2016年 马军. All rights reserved.
//


#import "WebKit/WebKit.h"
#import "PNShopViewController.h"
//#import "JWCacheURLProtocol.h"
#import "PNViewDetailController.h"
#import <SVProgressHUD.h>
#define IOS8x ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define WebViewNav_TintColor ([UIColor orangeColor])
#define HomeUrl1    [NSURL URLWithString:@"http://www.caifengwang.cn/"]
@interface PNShopViewController ()<WKNavigationDelegate,UIWebViewDelegate>
@property (nonatomic,strong) WKWebView *WKwebView;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIProgressView *progressView;
@property (assign, nonatomic) NSUInteger loadCount;
@end

@implementation PNShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addTitleViewWithTitle:@"商  城"];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [image setImage:[UIImage imageNamed:@"feedback.jpg"]];
    
    [self.view addSubview:image];
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.frame = CGRectMake(0, 100, 200,45);
    [b setTitle:@"点击进入商城" forState:UIControlStateNormal];
    [b addTarget:self action:@selector(bAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:b];
}


- (void)bAction{
    

    PNViewDetailController *shopDetailVC = [[PNViewDetailController alloc]init];
    [self presentViewController:shopDetailVC animated:YES completion:^{
        
    }];

}


@end
