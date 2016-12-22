//
//  PNQualityTestingViewController.m
//  cfw
//
//  Created by majun on 16/12/19.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNQualityTestingViewController.h"
#import "WebKit/WebKit.h"
//#import "JWCacheURLProtocol.h"

#import <SVProgressHUD.h>
#define IOS8x ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)
#define WebViewNav_TintColor ([UIColor orangeColor])
#define HomeUrl1    [NSURL URLWithString:@"http://192.168.0.156:8080/miningbee-web/checking1.jsp"]
@interface PNQualityTestingViewController ()<WKNavigationDelegate,UIWebViewDelegate,WKUIDelegate>
@property (nonatomic,strong) WKWebView *WKwebView;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIProgressView *progressView;
@property (assign, nonatomic) NSUInteger loadCount;
@end



@implementation PNQualityTestingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"质检审核"];
    // [self configUI];// 有进度条的
    [self WebUI]; // 没有进度条的
    [self NotPulldown]; // 禁止webview下拉
    
}



// 禁止webview下拉
- (void)NotPulldown{
    //iOS 5系统之前的版本
    for (id subview in self.WKwebView.subviews)
        if ([[subview class] isSubclassOfClass: [UIScrollView class]])
            ((UIScrollView *)subview).bounces = NO;
    
    //iOS 5之后的版本
    _WKwebView.scrollView.bounces = NO;
}

//// 隐藏状态栏
//- (BOOL)prefersStatusBarHidden
//{
//    return YES; // 返回NO表示要显示，返回YES将hiden
//}

- (void)WebUI{
    
    // 对wkwebview的配置
    WKWebViewConfiguration *config=[[WKWebViewConfiguration alloc]init];
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
    // web内容处理池，由于没有属性可以设置，也没有方法可以调用，不用手动创建
    config.processPool = [[WKProcessPool alloc] init];
    
    
    self.view.backgroundColor = [UIColor redColor];
    //使用方法，在开启webview的时候开启监听，，销毁weibview的时候取消监听，否则监听还在继续。将会监听所有的网络请求
    // [JWCacheURLProtocol startListeningNetWorking];
    
    self.WKwebView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height) configuration:config];
    
    self.WKwebView.allowsBackForwardNavigationGestures = YES;
    
    self.WKwebView.navigationDelegate = self;
#pragma mark ----  confirm 警示框 调用原生alert的代理方法
    self.WKwebView.UIDelegate = self; // confirm 警示框 调用原生alert的代理方法
    self.WKwebView.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"noload.jpg"]];
    [self.view addSubview:self.WKwebView];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
    
//       [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.tmall.com"]]];
    
    [self.WKwebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.0.156:8080/miningbee-web/checking1.jsp"]]];
    
    
    //
    //    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    button.frame = CGRectMake(40, 22, 50, 50);
    //    [button setImage:[UIImage imageNamed:@"login_close_icon@3x"] forState:UIControlStateNormal];
    //    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    //    [self.WKwebView addSubview:button];
    
}

-(void)btnLeftClick
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [SVProgressHUD dismiss];
}
#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    //   [SVProgressHUD showWithStatus:@"请稍等，店小二马上赶来"];
    
    
    NSLog(@"didStartProvisionalNavigation");
    
    NSString *newPath = webView.URL.absoluteString;
    NSLog(@"%@",newPath);
    
    
    if([newPath hasPrefix:@"tel:"]){
        
        [SVProgressHUD dismiss];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请问要拨打客服电话吗" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
            
            
            NSString *num = [[NSString alloc]initWithFormat:@"%@",newPath]; //而这个方法则打电话前先弹框 是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
            
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:NULL];
    }
    
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didCommitNavigation");
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"didFinishNavigation");
    
    // [SVProgressHUD dismiss];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    //[SVProgressHUD showErrorWithStatus:@"网络错误，请重新加载"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)configUI {
    
    // 进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)];
    progressView.tintColor = WebViewNav_TintColor;
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    // 网页
    if (IOS8x) {
        WKWebView *wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        wkWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        wkWebView.backgroundColor = [UIColor whiteColor];
        wkWebView.navigationDelegate = self;
        [self.view insertSubview:wkWebView belowSubview:progressView];
        
        [wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:HomeUrl1];
        [wkWebView loadRequest:request];
        self.WKwebView = wkWebView;
    }else {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        webView.scalesPageToFit = YES;
        webView.backgroundColor = [UIColor whiteColor];
        webView.delegate = self;
        [self.view insertSubview:webView belowSubview:progressView];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:HomeUrl1];
        [webView loadRequest:request];
        self.webView = webView;
        
    }
}


#pragma mark - wkWebView代理


/// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    
    NSLog(@"%ld",(long)navigationAction.navigationType);
    
    decisionHandler(WKNavigationActionPolicyAllow);
}


#pragma mark -- js交互

// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:message                 preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);
}

#pragma mark -- 设置webView背景图
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // self.tabBarController.tabBar.hidden = YES;
    //self.navigationController.navigationBar.hidden = YES;
    // 这里加载webView的背景图
    self.WKwebView.backgroundColor = [UIColor colorWithPatternImage:[self imageResize:[UIImage imageNamed:@"noload.jpg"] andResizeTo:self.WKwebView.bounds.size]];
    
}

// 自定义方法让colorWithPatternImage不拉伸
-(UIImage *)imageResize :(UIImage*)img andResizeTo:(CGSize)newSize
{
    CGFloat scale = [[UIScreen mainScreen]scale];
    
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [img drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



@end
