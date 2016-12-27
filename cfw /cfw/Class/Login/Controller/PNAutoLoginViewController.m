
//
//  PNAutoLoginViewController.m
//  cfw
//
//  Created by 马军 on 16/9/26.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNAutoLoginViewController.h"
//#import "PNiphoneNumber.h"
#import "RegistrationVC.h"
#import "MBProgressHUD.h"
#import "PNMapViewController.h"
#import "WXDataService.h"
#import "PNiphoneNumber.h"
#import "RegistrationVC.h"
@interface PNAutoLoginViewController ()
{
    UIImageView *image;

}

@property(nonatomic,strong)NSString *userTel; //sim卡获取到的手机号


@end

@implementation PNAutoLoginViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"注册";
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

   // NSLog(@"%@",[PNiphoneNumber myNumber]);
   
    [self setUpView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 50, 50);
    [button setImage:[UIImage imageNamed:@"login_close_icon@3x"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnLeftClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
}

-(void)btnLeftClick
{
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)setUpView{
    
    
     image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [image setImage:[UIImage imageNamed:@"zhuce_bj"]];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"请输入手机号登录";
    label.textColor = [UIColor redColor];
    
    
    UITextField *textField = [[UITextField alloc]init];
    textField.tag = 100;
    textField.layer.cornerRadius = 10;
    textField.layer.masksToBounds = YES;
    textField.layer.borderWidth = 2;
    textField.layer.borderColor = [UIColor grayColor].CGColor;
    textField.placeholder = @"请输入手机号";
    
    
    UIButton *btn = [[UIButton alloc]init];
    btn.layer.cornerRadius = 10;
    btn.layer.masksToBounds = YES;
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [UIColor grayColor].CGColor;
  
    [btn setTitle:@"一键登录" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btn1 = [[UIButton alloc]init];
    
    btn1.layer.cornerRadius = 10;
    btn1.layer.masksToBounds = YES;
    btn1.layer.borderWidth = 2;
    btn1.layer.borderColor = [UIColor grayColor].CGColor;
    
    [btn1 setTitle:@"前往注册" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
   
    [self.view addSubview:image];
    [self.view addSubview:btn];
    [self.view addSubview:textField];
    [self.view addSubview:label];
    [self.view addSubview:btn1];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-120);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(btn).offset(70);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(btn).offset(-70);
        make.size.mas_equalTo(CGSizeMake(150, 50));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(textField).offset(-60);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
}

- (void)btnAction1{
    NSLog(@"前往注册");
    
    
    RegistrationVC *registVC = [[RegistrationVC alloc]init];
    [self presentViewController:registVC animated:YES completion:^{
        
    }];
    
    
    
}


- (void)btnAction{
    NSLog(@"一键登录");
    
    [self autoLogin];
    
    
}

- (void)autoLogin{
    
    UITextField *iPhoneNum = [self.view viewWithTag:100];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
#warning 请输入注册调用的网址
    
    NSString *urlStringlogin = @"http://bee.prismnetwork.cn/ws/login/go/";
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];//默认的方式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
    
    
    if (iPhoneNum.text.length == 11) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"验证通过";
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        // 1秒之后再消失
        [hud hide:YES afterDelay:1.5];
  // 18321933220
        
        NSString  *urlStringlogingo = [NSString stringWithFormat:@"%@%@",urlStringlogin,iPhoneNum.text];
        
        
        [manager GET:urlStringlogingo parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            //数据加载完后回调.
            NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            NSLog(@"result = %@",responseObject);
            
            NSLog(@"========%@",result);
            
//            NSData *response = [NSURLConnection sendSynchronousRequest:responseObject returningResponse:nil error:nil];
            //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
            NSDictionary *userDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            
            NSString *uid = [userDic objectForKey:@"uid"];
            
//            NSDictionary *weatherInfo = [weatherDic objectForKey:@"weatherinfo"];
            
//            NSLog(@"weatherDic===%@",weatherDic);
            
            // 把后台返回的user信息保存到NSUserDefaults
            
            
            // 发送网络请求，假如返回结果为 result = @"1";
            // NSString *result = @"1";
            if (result)
            {
                //是否是自动登录
                BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
                if (!isAutoLogin)
                {
                    EMError *error = [[EMClient sharedClient] loginWithUsername:iPhoneNum.text password:@"123456"];
                    if (!error)
                    {
                        [[EMClient sharedClient].options setIsAutoLogin:YES];
                        NSString *name = [NSString stringWithFormat:@"%@",iPhoneNum.text];
                        //                NSLog(@"写入之前++++++++++++++++++%@",name);
                        
                        NSDictionary *resultDiction = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"loginState",name,@"name",uid,@"uid" ,nil];
                        
                        [[NSUserDefaults standardUserDefaults] setObject:resultDiction forKey:@"ResultAuthData"];
                        //保存数据，实现持久化存储
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.label.text = @"注册成功!";
                        hud.detailsLabel.text = @"正在为您登录...";
                        // 隐藏时候从父控件中移除
                        hud.removeFromSuperViewOnHide = YES;
                        // 1秒之后再消失
                        [hud hideAnimated:YES afterDelay:3.5];
                        
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            
                            
                            [UIView animateWithDuration:4.0 animations:^{
                                
                                [self dismissViewControllerAnimated:YES completion:^{
                                    
                                }];
                                NSLog(@"这里直接跳转到首页");
                            }];
                            
                        });
                    }
                }
                else
                {
                    NSString *name = [NSString stringWithFormat:@"%@",iPhoneNum.text];
                    //                NSLog(@"写入之前++++++++++++++++++%@",name);
                    
                    NSDictionary *resultDiction = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"loginState",name,@"name",uid,@"uid" ,nil];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:resultDiction forKey:@"ResultAuthData"];
                    //保存数据，实现持久化存储
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    hud.label.text = @"注册成功!";
                    hud.detailsLabel.text = @"正在为您登录...";
                    // 隐藏时候从父控件中移除
                    hud.removeFromSuperViewOnHide = YES;
                    // 1秒之后再消失
                    [hud hideAnimated:YES afterDelay:3.5];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                        
                        [UIView animateWithDuration:4.0 animations:^{
                            
                            [self dismissViewControllerAnimated:YES completion:^{
                                
                            }];
                            NSLog(@"这里直接跳转到首页");
                        }];
                        
                    });
 
                }
                
                
            }else{
                
//                RegistrationVC *registrVC = [[RegistrationVC alloc]init];
//                [self.navigationController pushViewController:registrVC animated:YES];
                
            }
            
            
        }failure:^(NSURLSessionDataTask *task, NSError *error) {
            //数据加载失败回调.
            NSLog(@"发送验证码失败: %@",error);
            
//            RegistrationVC *registrVC = [[RegistrationVC alloc]init];
//            //            [self presentViewController:registrVC animated:YES completion:nil];
//            [self.navigationController pushViewController:registrVC animated:YES];
        }];
        
    }else{
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"手机号码格式有误,请重新填写";
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        // 1秒之后再消失
        [hud hide:YES afterDelay:1.5];
        
        NSLog(@"取不到手机号，跳到手动注册页面");
        
        
//        RegistrationVC *registrVC = [[RegistrationVC alloc]init];
//        //        [self presentViewController:registrVC animated:YES completion:nil];
//        [self.navigationController pushViewController:registrVC animated:YES];
        
    }

}


#pragma lazy

- (NSString *)userTel{
    if (!_userTel) {
        _userTel = [[NSString alloc]init];
    }
    return _userTel;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
