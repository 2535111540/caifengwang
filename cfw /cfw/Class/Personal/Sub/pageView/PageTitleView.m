//
//  PageTitleView.m
//  QFB
//
//  Created by yl on 2016/11/3.
//  Copyright © 2016年 shujuyun. All rights reserved.
//

#import "PageTitleView.h"
@interface PageTitleView()
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *scrollLine;
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,strong) NSMutableArray *labelsArr;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation PageTitleView
// 懒加载属性
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.bounces = NO;
    }
    return _scrollView;
}
- (NSArray *)titles
{
    if (!_titles) {
        self.titles = [NSArray array];
    }
    return _titles;
}
-(NSMutableArray *)labelsArr
{
    if (!_labelsArr) {
        self.labelsArr = [NSMutableArray array];
    }
    return _labelsArr;
}
- (UIView *)scrollLine
{
    if (!_scrollLine) {
        self.scrollLine = [[UIView alloc] init];
        self.scrollLine.backgroundColor = [UIColor colorWithR:40 g:146 b:192];
//        self.scrollLine.backgroundColor = [UIColor whiteColor];
    }
    return _scrollLine;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    _titles = titles;
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        self.currentIndex = 0;
    }
    return self;
}

- (void)setupUI {
    // 1.添加scrollView
    [self addSubview:self.scrollView];
    self.scrollView.frame = self.bounds;
    
    // 2.添加label
    [self setupTitleLabel];
    
    // 3.添加scrollView下面的底线
    [self setuiScrollLine];
    
}

- (void)setupTitleLabel
{
    CGFloat labelW = self.frame.size.width / (CGFloat)self.titles.count;
    CGFloat labelH = self.frame.size.height - 13;
    CGFloat labelY = 0;
    for (int i = 0; i < self.titles.count; i++) {
        self.label = [[UILabel alloc] init];
        self.label.text = self.titles[i];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:16.0];
        self.label.textColor = [UIColor lightGrayColor];
        self.label.tag = i;
        self.label.frame = CGRectMake(labelW * i, labelY, labelW, labelH);
        [self.scrollView addSubview:self.label];
        [self.labelsArr addObject:self.label];
        
        self.label.userInteractionEnabled = YES;
        UITapGestureRecognizer *labTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labTapClick:)];
        [self.label addGestureRecognizer:labTap];
    }
}

- (void)setuiScrollLine
{
    UIView *bottomLine = [[UIView alloc] init];
//    bottomLine.backgroundColor = [UIColor colorWithR:232 g:240 b:243];
    bottomLine.backgroundColor = [UIColor whiteColor];
    UILabel *firstlabel = self.labelsArr[0];
    firstlabel.textColor = [UIColor colorWithR:40 g:146 b:192];
//    firstlabel.backgroundColor = [UIColor whiteColor];
    CGFloat lineH = 10;
    bottomLine.frame = CGRectMake(0, self.height - lineH, kScreenW, lineH);
    [self addSubview:bottomLine];
    
    // 添加scrollLine
    UILabel *firstLaebl = self.labelsArr.firstObject;
    self.scrollLine.frame = CGRectMake(firstLaebl.frame.origin.x, self.height - lineH - 3, firstLaebl.width, 3);
    [self.scrollView addSubview:self.scrollLine];
    
}

#pragma mark --- 监听label点击
- (void)labTapClick:(UITapGestureRecognizer *)tap
{
    UILabel *currentLabel = (UILabel *)tap.view;

    if (currentLabel.tag == _currentIndex) {
        return;
    }else {
        // 1.首先要保存改变之前的label,也就是没有改变之前的时候的当前的label
        UILabel *beforeLabel = self.labelsArr[_currentIndex];
        // 2.在这可以修改字体颜色，或者其他属性 （这里不做操作了）
        currentLabel.textColor = [UIColor colorWithR:40 g:146 b:192];
//        currentLabel.backgroundColor = [UIColor whiteColor];
        beforeLabel.textColor = [UIColor lightGrayColor];
        // 3.保存最新的index
        self.currentIndex = currentLabel.tag;
        
        // 4.底线的偏移量
        CGFloat scrollLineX = self.currentIndex * self.scrollLine.width;
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollLine.x = scrollLineX;
        }];
    }
    
    if ([self.delegate respondsToSelector:@selector(pageTitleViewCurrentIndex:)]) {
        [self.delegate pageTitleViewCurrentIndex:self.currentIndex];
    }
}

// 对外暴露一个方法，来进行和pagecontentView进行交互
- (void)setTitleChangeProgress:(CGFloat)progress beforeIndex:(NSInteger)beforIndex targetIndex:(NSInteger)targetIndex
{
    // 取出beforIndex/targetIndex对应的label
    UILabel *beforLabel = self.labelsArr[beforIndex];
    UILabel *targetLabel = self.labelsArr[targetIndex];
    
    CGFloat moveTotalX = targetLabel.x - beforLabel.x;
    CGFloat titleMoveX = moveTotalX * progress;
    self.scrollLine.x = beforLabel.x + titleMoveX;
    
    if (progress > 0.5) {
        beforLabel.textColor = [UIColor lightGrayColor];
        targetLabel.textColor = [UIColor colorWithR:40 g:146 b:192];
//        targetLabel.backgroundColor = [UIColor whiteColor];
    }

    
    // 将最新的index赋值给当前的Index
    self.currentIndex = targetIndex;
}

@end
