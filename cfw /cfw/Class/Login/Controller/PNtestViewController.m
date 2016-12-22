//
//  PNtestViewController.m
//  cfw
//
//  Created by majun on 16/12/20.
//  Copyright © 2016年 马军. All rights reserved.
//

#import "PNtestViewController.h"

@interface PNtestViewController ()

@end

@implementation PNtestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.prompt = @ "CTTelephonyNetworkInfo" ;
    
    self.navigationItem.title = @ "CTCarrier" ;
    //初始化
    
    networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    //当sim卡更换时弹出此窗口
    
    networkInfo.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *carrier){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@ "Sim card changed" delegate:nil cancelButtonTitle:@ "Dismiss" otherButtonTitles:nil];
        
        [alert show];
        
        
        
    };
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    //获取sim卡信息
    
    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
    
    static NSString *CellIdentifier = @ "Cell" ;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    switch (indexPath.row) {
            
        case 0 : //供应商名称（中国联通 中国移动）
            
            cell.textLabel.text = @ "carrierName" ;
            
            cell.detailTextLabel.text = carrier.carrierName;
            
            break ;
            
        case 1 : //所在国家编号
            
            cell.textLabel.text = @ "mobileCountryCode" ;
            
            cell.detailTextLabel.text = carrier.mobileCountryCode;
            
            break ;
            
        case 2 : //供应商网络编号
            
            cell.textLabel.text = @ "mobileNetworkCode" ;
            
            cell.detailTextLabel.text = carrier.mobileNetworkCode;
            
            break ;
            
        case 3 :
            
            cell.textLabel.text = @ "isoCountryCode" ;
            
            cell.detailTextLabel.text = carrier.isoCountryCode;
            
            break ;
            
        case 4 : //是否允许voip
            
            cell.textLabel.text = @ "allowsVOIP" ;
            
            cell.detailTextLabel.text = carrier.allowsVOIP?@ "YES" :@ "NO" ;
            
            break ;
            
            
            
        default :
            
            break ;
            
    }
    
    
    
    return cell;

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
