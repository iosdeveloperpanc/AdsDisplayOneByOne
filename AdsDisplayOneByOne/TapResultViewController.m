//
//  TapResultViewController.m
//  AdsDisplayOneByOne
//
//  Created by Pan on 15/9/11.
//  Copyright (c) 2015年 lanyao. All rights reserved.
//

#import "TapResultViewController.h"

@interface TapResultViewController ()

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation TapResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.resultLabel setText:self.result];
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
