//
//  RegistrationVC.m
//
//  Created by 广州动创 on 16/4/20.
//  Copyright © 2016年 广州动创. All rights reserved.
//
#import "RegistrationVC.h"
#import "UIViewExt.h"
#import "MBProgressHUD.h"
#import "WXDataService.h"
#import <SMS_SDK/SMSSDK.h>
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
#import "PNMapViewController.h"
@interface RegistrationVC ()<UITextFieldDelegate,NSURLConnectionDataDelegate>

{
    UIButton *btn;
    NSTimer *timer;
    NSTimer *timer2;
    NSInteger timeCount;
    UIButton *registeBtn;
    MBProgressHUD *hud;
    UITextField *text;
    NSString *result;// 后台返回的数据
    NSDictionary *resultDic; // 后台返回的数据
}

@property(nonatomic,strong)UIAlertController *alertC;//提示框
@property(nonatomic,copy) NSString *numCode;
@end

@implementation RegistrationVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed=YES;
    }
    return self;  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addTitleViewWithTitle:@"注册"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatRegistSubviews];
    
    
    
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


-(void)creatRegistSubviews{
    
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,KScreenWidth,KScreenHeight)];
    [image setImage:[UIImage imageNamed:@"zhuce_bj"]];
    [self.view addSubview:image];
    
    NSArray *arr = @[@"手机号码",@"验证码"];
    for (int i=0; i<arr.count; i++) {
        
       UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(30, 300+i*60, KScreenWidth-60, 50)];


        [self.view addSubview:textF];
        textF.placeholder = arr[i];
        textF.delegate = self;
        textF.tag = 100+i;
        textF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        textF.borderStyle = UITextBorderStyleRoundedRect;
        textF.borderStyle = UITextBorderStyleNone;
        textF.layer.borderWidth = 1;
        textF.layer.borderColor = [[UIColor lightGrayColor]CGColor];
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 50)];
        textF.leftView = view;
        textF.leftViewMode = UITextFieldViewModeAlways;
        
        if (i == 1) {
            
            btn = [[UIButton alloc]initWithFrame:CGRectMake(textF.right-170, textF.origin.y+7, 160, 36)];
            btn.layer.cornerRadius = 18;
            [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction1) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = [UIColor colorWithRed:0.957 green:0.306 blue:0.235 alpha:1.000];
            [self.view addSubview:btn];
        }else if(i == 1){
            textF.secureTextEntry = YES;
        }
    }
    
    UITextField *textF = [self.view viewWithTag:100+arr.count-1];
    registeBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, textF.bottom+30, textF.width, 44)];
    [registeBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registeBtn.backgroundColor = [UIColor lightGrayColor];
    registeBtn.layer.cornerRadius = 7;
    [registeBtn addTarget:self action:@selector(registeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registeBtn];
    
}

-(void)registeBtnAction{
    
    if (registeBtn.backgroundColor != [UIColor lightGrayColor]) {
        
        NSLog(@"注册Yes");
        UITextField *textF = [self.view viewWithTag:100];
        UITextField *textF2 = [self.view viewWithTag:101];
        if (textF.text.length != 11) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"手机号码格式有误,请重新填写";
            // 隐藏时候从父控件中移除
            hud.removeFromSuperViewOnHide = YES;
            // 1秒之后再消失
            [hud hide:YES afterDelay:1.5];
            
            
        }else if(textF2.text.length == 6){
            
            NSLog(@"进入验证----------");
            
            NSLog(@"%@",self.numCode);
            if ([textF2.text isEqual:self.numCode]) {
                NSLog(@"验证成功");
                
                
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"验证通过正在进入";
                // 隐藏时候从父控件中移除
                hud.removeFromSuperViewOnHide = YES;
                // 1秒之后再消失
                [hud hide:YES afterDelay:1.5];
                
                
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
                
#warning 请输入注册调用的网址
                
                NSString *urlString = @"http://bee.prismnetwork.cn/ws/simpleRegister/save/";
                
                manager.requestSerializer = [AFHTTPRequestSerializer serializer];//默认的方式
                manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//                [manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"x-access-id"];
//                [manager.requestSerializer setValue:@"123" forHTTPHeaderField:@"x-signature"];
                
                NSString  *urlStringNO = [NSString stringWithFormat:@"%@%@",urlString,textF.text];
                [manager GET:urlStringNO parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                    //数据加载完后回调.
                    //                            result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                    //
                    //                            NSLog(@"ffffffffff%@",result);
                    
                    resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                    
                    
                    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                    hud.mode = MBProgressHUDModeText;
                    
                    NSLog(@"注册成功===");
                    [self registerSuccess];//注册成功后调用
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    //数据加载失败回调.
                    NSLog(@"%@",error);
    
                    NSLog(@"注册失败了");
                }];
                

            }
            

        
        }

        
    }else{
        NSLog(@"注册NO");
    }
}

//注册成功
-(void)registerSuccess{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"注册成功!";
    hud.detailsLabelText = @"正在为您登录...";
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hide:YES afterDelay:4];
    
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
}

-(void)delayMethod{
    
//    [self dismissViewControllerAnimated:YES completion:^{
//         NSLog(@"zzzzzzzzzzzzzzzzzzzzzzzzzz");
//    }];
    
    UITextField *textF = [self.view viewWithTag:100];
    [self.navigationController popToRootViewControllerAnimated:YES];
    NSLog(@"错误所在 ！！");
    
    // 取出name
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:resultDic];
    NSString *name = [dic objectForKey:@"name"];
    
    // 取出uid
    NSString *uid = [dic objectForKey:@"uid"];

    
    NSDictionary *resultDiction = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"status",uid,@"uid",name,@"name", nil];
    
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
                                @"status" : @"1",
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
           }];
    

}

-(void)btnAction1{
    
    UITextField *textF = [self.view viewWithTag:100];
    if (textF.text.length != 11) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"请输入正确的手机号";
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = YES;
        // 1秒之后再消失
        [hud hideAnimated:YES afterDelay:1.5];
    }else{
        
        
    
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];//默认的方式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
#warning 请输入注册调用的网址
        
        
        // 随机产生6位验证码
        int num = (arc4random() % 1000000);
       NSString *randomNumber = [NSString stringWithFormat:@"%.6d", num];
        NSLog(@"随机产生6位验证码：%@", randomNumber);
        self.numCode = randomNumber;
        NSLog(@"numbCode=%@",self.numCode);
        // 给用户发送短息的内容
        NSString *MessageBody = [NSString stringWithFormat:@"【采蜂网】会员登录验证信息，用户验证码为：%@,请牢记您的验证码以便于使用",randomNumber];
        // 中国短信网的请求接口
        NSString *sendMessageUrl = [[NSString stringWithFormat:@"http://smsapi.c123.cn/OpenPlatform/OpenApi?action=sendOnce&ac=1001@501360820001&authkey=2B6ECBB4E621A733F6D1882DF60A0655&cgid=7617&c=%@&m=%@",MessageBody,textF.text]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
      [manager GET:sendMessageUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
          
          NSData *data = [NSData dataWithData:responseObject];
          NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"中国短信网返回的数据：%@",result);
          NSLog(@"验证码发送成功");

          hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
          hud.mode = MBProgressHUDModeText;
            if(result){
            hud.label.text = @"短信已发至你手机，请注意查收！";
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(reduceTime:) userInfo:nil repeats:YES];
            timeCount = 60;
           hud.removeFromSuperViewOnHide = YES;
                // 1秒之后再消失
           [hud hideAnimated:YES afterDelay:1.5];
            }
          
                
            }failure:^(NSURLSessionDataTask *task, NSError *error) {
                
            NSLog(@"获取验证码失败%@",error.description);
                
            hud.label.font = [UIFont systemFontOfSize:16];
            hud.label.text = @"该手机无法接收到短信,请再试一次";
                
           // 隐藏时候从父控件中移除
           hud.removeFromSuperViewOnHide = YES;
           // 1秒之后再消失
           [hud hideAnimated:YES afterDelay:1.5];
           NSLog(@"验证码发送失败");
         
            }];

    
    
     }
}

- (void)reduceTime:(NSTimer *)codeTimer {
    timeCount--;
    if (timeCount == 0) {
        [btn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UIButton *info = codeTimer.userInfo;
        info.enabled = YES;
        btn.userInteractionEnabled = YES;
        [timer invalidate];
    } else {
        NSString *str = [NSString stringWithFormat:@"%lu秒后重新获取", (long)timeCount];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.userInteractionEnabled = NO;
        
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(textFTime1) userInfo:nil repeats:YES];
    
}

-(void)textFTime1{
    
    UITextField *textF = [self.view viewWithTag:100];
    UITextField *textF2 = [self.view viewWithTag:101];
//    UITextField *textF3 = [self.view viewWithTag:102];
    
    if (textF.text.length > 0 && textF2.text.length > 0 ) {
        
        registeBtn.backgroundColor = [UIColor colorWithRed:0.002 green:0.774 blue:0.003 alpha:1.000];
        [timer2 invalidate];
        
    }else{
        registeBtn.backgroundColor = [UIColor lightGrayColor];
    }
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)checkVerityCode {
    UITextField *textF = [self.view viewWithTag:100];
    UITextField *textF2 = [self.view viewWithTag:101];
    [SMSSDK commitVerificationCode:textF2.text phoneNumber:textF.text zone:@"86" result:^(NSError *error) {
        if (error) {
            NSLog(@"验证码有误");
            //说明60秒已经结束并且还没有得到验证码,这时候我们应该将定时器暂停或者销毁
            [btn setTitle:@"再次发送" forState:UIControlStateNormal];
            //打开用户交互
            btn.enabled = YES;
            //销毁定时器
            [timer invalidate];
            timer = nil;
        } else {
            NSLog(@"验证成功");
            text.text = textF2.text;
            NSLog(@"tttttttttttt%@",text.text);
        }
    }];
}



#pragma mark - 提示框
- (void)alertActionWithTitle:(NSString*)title message:(NSString*)message {
    self.alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    //create the actions
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //Add the actions
    [self.alertC addAction:cancelAction];
    [self.alertC addAction:okAction];
    [self presentViewController:self.alertC animated:YES completion:nil];
}






- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    if (self.isViewLoaded && !self.view.window) {
        
        self.view = nil;
    }
}



@end
