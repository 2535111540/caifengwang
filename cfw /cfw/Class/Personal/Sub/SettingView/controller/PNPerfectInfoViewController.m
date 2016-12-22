//
//  PNPerfectInfoViewController.m
//  cfw
//
//  Created by majun on 16/12/18.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNPerfectInfoViewController.h"
#import "LXSegmentScrollView.h"
#import "PNFengQiViewController.h"
#import "PNFengNongViewController.h"
#import "PageTitleView.h"
#import "PageContentView.h"



#define kTitleViewH 50
@interface PNPerfectInfoViewController ()<PageContentViewDelegate,PageTitleViewDelegate>
@property (nonatomic,strong) NSMutableArray *childVcs;
@property (nonatomic,strong) PageTitleView *titleView;
@property (nonatomic,strong) PageContentView *pageContentView;
@end

@implementation PNPerfectInfoViewController

// 懒加载初始化数组
- (NSMutableArray *)childVcs
{
    if (!_childVcs) {
        self.childVcs = [NSMutableArray arrayWithCapacity:2];
    }
    return _childVcs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资料完善";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 不需要调整UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupUI];
    
    
}
- (void)setupUI {
    // 添加titleView
    NSArray *titlesArr = @[@"蜂农",@"蜂企"];
    PageTitleView *titleView = [[PageTitleView alloc] initWithFrame:CGRectMake(0, kStatusBarH + kNavigationBarH, kScreenW, kTitleViewH) titles:titlesArr];
    titleView.delegate = self;
    self.titleView = titleView;
    [self.view addSubview:titleView];
    
    // 添加pageContentView
        [self addPageContentView];
}

- (void)addPageContentView
{
    CGFloat contentViewH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH;
    CGRect contentViewFrame = CGRectMake(0, kStatusBarH + kNavigationBarH + kTitleViewH, kScreenW, contentViewH);
    
    PNFengNongViewController * pnfengnongView =[[PNFengNongViewController alloc]init];
    PNFengQIViewController * pnfengqiView =[[PNFengQIViewController alloc]init];
    
    [self.childVcs addObject:pnfengnongView];
    [self.childVcs addObject:pnfengqiView];
    
    NSLog(@"%lu",(unsigned long)self.childVcs.count);
    PageContentView *pageContentView = [[PageContentView alloc] initWithFrame:contentViewFrame childVcs:self.childVcs parentViewController:self];
    pageContentView.delegate = self;
    self.pageContentView = pageContentView;

    [self.view addSubview:pageContentView];
}

#pragma mark ----- 代理
- (void)pageContentViewProgress:(CGFloat)progress beforeIndex:(NSInteger)beforIndex targetIndex:(NSInteger)targetIndex
{
    [self.titleView setTitleChangeProgress:progress beforeIndex:beforIndex targetIndex:targetIndex];
}

- (void)pageTitleViewCurrentIndex:(NSInteger)currentIndex
{
    [self.pageContentView setPageContentViewChangeCurrentIndex:currentIndex];
}


@end
