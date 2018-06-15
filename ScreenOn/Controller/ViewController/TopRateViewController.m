//
//  TopRateViewController.m
//  ScreenOn
//
//  Created by Chin Wee Kerk on 15/06/2018.
//  Copyright © 2018 Chin Wee Kerk. All rights reserved.
//

#import "TopRateViewController.h"

@interface TopRateViewController ()

@end

@implementation TopRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addInstitialAdmobWithAdID:@"ca-app-pub-1749500499268006/6074955007"];
    [self startInstitialAdmobWithdeviceID:@"763ea513d683f24535cbd93b1d0e2e7d"];
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
