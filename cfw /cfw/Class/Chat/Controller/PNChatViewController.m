//
//  PNChatViewController.m
//  cfw
//
//  Created by majun on 16/10/20.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNChatViewController.h"
#import "AKSegmentedControl.h"
#import "JHCustomMenu.h"

#import "PNMessageViewController.h"


#pragma mark HXUI
#import "ContactListViewController.h" // 通讯录列表
#import "ConversationListController.h" // 会话列表

#import "AddFriendViewController.h"//添加好友
@interface PNChatViewController () <AKSegmentedControlDelegate,JHCustomMenuDelegate>

{
    UITableView *_tableView;
    AKSegmentedControl *segmentedControl;
    
    PNMessageViewController *messageVC;
    ContactListViewController *contactListVC;
    ConversationListController *conversationListVC;
}
@property (nonatomic, strong) JHCustomMenu *menu;

@property (nonatomic, strong) ContactListViewController *currentVC;
@end

@implementation PNChatViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    

    segmentedControl = [[AKSegmentedControl alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];

    segmentedControl.delegate = self;
    
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"schoolListItem.png"] style:UIBarButtonItemStylePlain target:self action:@selector(showList:)];
    
    self.navigationItem.rightBarButtonItem = leftItem;

    self.currentVC = self.contactListVC; // 设置默认VC
    
    [self setupSegmentedControl];
    
}


- (void)showList:(UIBarButtonItem *)barButtonItem
{
    __weak __typeof(self) weakSelf = self;
    if (!self.menu) {
        self.menu = [[JHCustomMenu alloc] initWithDataArr:@[@"校内群聊", @"邀请好友"] origin:CGPointMake(0, 0) width:125 rowHeight:44];
        _menu.delegate = self;
        _menu.dismiss = ^() {
            weakSelf.menu = nil;
        };
        _menu.arrImgName = @[@"item_chat.png", @"item_share.png"];
        [self.view addSubview:_menu];
    } else {
        [_menu dismissWithCompletion:^(JHCustomMenu *object) {
            weakSelf.menu = nil;
        }];
    }
}

- (void)jhCustomMenu:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select: %ld", indexPath.row);
    
    if (indexPath.row == 0) {
        
        NSLog(@"群聊");
    }else if (indexPath.row == 1){
        AddFriendViewController *addFriends = [[AddFriendViewController alloc]init];
        [self.navigationController pushViewController:addFriends animated:YES];
    }
}

- (void)setupSegmented{
    
}


- (void)setupSegmentedControl
{
    UIImage *backgroundImage = [[UIImage imageNamed:@"segmented-bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [segmentedControl setBackgroundImage:backgroundImage];
    [segmentedControl setContentEdgeInsets:UIEdgeInsetsMake(2.0, 2.0, 3.0, 2.0)];
    [segmentedControl setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin];
    
    [segmentedControl setSeparatorImage:[UIImage imageNamed:@"segmented-separator.png"]];
    
    UIImage *buttonBackgroundImagePressedLeft = [[UIImage imageNamed:@"segmented-bg-pressed-left.png"]
                                                 resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    UIImage *buttonBackgroundImagePressedCenter = [[UIImage imageNamed:@"segmented-bg-pressed-center.png"]
                                                   resizableImageWithCapInsets:UIEdgeInsetsMake(0.0, 4.0, 0.0, 1.0)];
    
    // Button 1
    UIButton *buttonSocial = [[UIButton alloc] init];
    [buttonSocial setTitle:@"好友" forState:UIControlStateNormal];
    [buttonSocial setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonSocial setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonSocial.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonSocial.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonSocial setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    UIImage *buttonSocialImageNormal = [UIImage imageNamed:@"social-icon.png"];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateHighlighted];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:UIControlStateSelected];
    [buttonSocial setBackgroundImage:buttonBackgroundImagePressedLeft forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateNormal];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateSelected];
    [buttonSocial setImage:buttonSocialImageNormal forState:UIControlStateHighlighted];
    [buttonSocial setImage:buttonSocialImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    // Button 2
    UIButton *buttonStar = [[UIButton alloc] init];
    UIImage *buttonStarImageNormal = [UIImage imageNamed:@"star-icon.png"];
    
    [buttonStar setTitle:@"消息" forState:UIControlStateNormal];
    [buttonStar setTitleColor:[UIColor colorWithRed:82.0/255.0 green:113.0/255.0 blue:131.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [buttonStar setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonStar.titleLabel setShadowOffset:CGSizeMake(0.0, 1.0)];
    [buttonStar.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0]];
    [buttonStar setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateHighlighted];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:UIControlStateSelected];
    [buttonStar setBackgroundImage:buttonBackgroundImagePressedCenter forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateNormal];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateSelected];
    [buttonStar setImage:buttonStarImageNormal forState:UIControlStateHighlighted];
    [buttonStar setImage:buttonStarImageNormal forState:(UIControlStateHighlighted|UIControlStateSelected)];

    
    [segmentedControl setButtonsArray:@[buttonSocial, buttonStar]];
    
    
    self.navigationItem.titleView = segmentedControl;
}

#pragma mark -
#pragma mark AKSegmentedControlDelegate

- (void)segmentedViewController:(AKSegmentedControl *)segmentedControls touchedAtIndex:(NSUInteger)index
{
    if (segmentedControls == segmentedControl) {
        NSLog(@"SegmentedControl #1 : Selected Index %lu", (unsigned long)index);
        
        
        if (index == 0) {
            NSLog(@"好友");
//            [self.view addSubview:self.friendVC.view];
            [self.view addSubview:self.contactListVC.view];
        
        }else if (index == 1){
            NSLog(@"消息");
//            [self.view addSubview:self.messageVC.view];
            
            [self.view addSubview:self.conversationListVC.view];
        }
        
    }
}
#pragma mark -- lazy


- (PNMessageViewController *)messageVC{
    if (!messageVC) {
        messageVC = [[PNMessageViewController alloc]init];
        [self addChildViewController:messageVC];
        [self.view addSubview:messageVC.view];
    }
    return messageVC;
}

- (ContactListViewController *)contactListVC{
    
    if (!contactListVC) {
        contactListVC = [[ContactListViewController alloc]init];
        [self addChildViewController:contactListVC];
        [self.view addSubview:contactListVC.view];
    }
    
    return contactListVC;
}

- (ConversationListController *)conversationListVC{
    if (!conversationListVC) {
        conversationListVC = [[ConversationListController alloc]init];
        [self addChildViewController:conversationListVC];
        [self.view addSubview:conversationListVC.view];
    }
    return conversationListVC;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
