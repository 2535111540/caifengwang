//
//  CFZTInfoViewViewController.m
//  BluetoothBox
//
//  Created by Tang on 2016/12/22.
//  Copyright © 2016年 Actions. All rights reserved.
//

#import "PNFengQIViewController.h"

@interface PNFengQIViewController ()


@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *storeTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *locationTextFiledlocation;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *emailTextFiled;

@end

@implementation PNFengQIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}





- (IBAction)cleanButtonClick:(id)sender {
    
    _nameTextFiled.text = @"";
    _storeTextFiled.text = @"";
    _locationTextFiledlocation.text = @"";
    _phoneTextFiled.text = @"";
    _emailTextFiled.text = @"";
    
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
