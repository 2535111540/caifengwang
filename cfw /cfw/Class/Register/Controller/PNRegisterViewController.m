//
//  PNRegisterViewController.m
//  cfw
//
//  Created by 马军 on 16/9/27.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNRegisterViewController.h"
#import "Masonry.h"
@interface PNRegisterViewController ()

@end

@implementation PNRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    [self setUpSubViews];
}


- (void)setUpSubViews{
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height)];
    [image setImage:[UIImage imageNamed:@"zhuce_bj"]];
    [self.view addSubview:image];
    
    UILabel *iphoneNum = [[UILabel alloc]init];
    iphoneNum.text = @"手机号:";
    iphoneNum.textColor = [UIColor redColor];
    iphoneNum.font = [UIFont systemFontOfSize:15];
    iphoneNum.backgroundColor = [UIColor brownColor];
    
    UILabel *verifiCode = [[UILabel alloc]init];
    verifiCode.text = @"验证码:";
    verifiCode.textColor = [UIColor orangeColor];
    verifiCode.font = [UIFont systemFontOfSize:15];
    verifiCode.backgroundColor = [UIColor redColor];
    
    UITextField *numTextField = [[UITextField alloc]init];
    numTextField.borderStyle = UITextBorderStyleRoundedRect;
    numTextField.placeholder = @"请输入手机号";
    numTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    numTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    
    UITextField *pwdTextField = [[UITextField alloc]init];
    pwdTextField.borderStyle = UITextBorderStyleRoundedRect;
    pwdTextField.placeholder = @"请输入验证码";
    pwdTextField.font = [UIFont fontWithName:@"Arial" size:20.0f];
    pwdTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    
    [self.view addSubview:iphoneNum];
    [self.view addSubview:verifiCode];
    [self.view addSubview:numTextField];
    [self.view addSubview:pwdTextField];

    
    [iphoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view).offset(-250);
        make.size.mas_equalTo(CGSizeMake(50, 45));
    }];
    
    [verifiCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(iphoneNum.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 45));
    }];
    
    [numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iphoneNum.mas_right).offset(20);
        make.top.equalTo(iphoneNum.mas_top);
        make.right.equalTo(self.view).offset(-50);
        make.height.equalTo(iphoneNum.mas_height);
        
    }];
    [pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verifiCode.mas_right).offset(20);
        make.top.equalTo(verifiCode.mas_top);
        make.right.equalTo(self.view).offset(-50);
        make.height.equalTo(verifiCode.mas_height);
    }];
    
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
