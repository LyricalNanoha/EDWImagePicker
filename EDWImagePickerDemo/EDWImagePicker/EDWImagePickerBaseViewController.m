//
//  EDWImagePickerBaseViewController.m
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EDWImagePickerBaseViewController.h"

@interface EDWImagePickerBaseViewController ()

@end

@implementation EDWImagePickerBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(EDWImagePickerViewController *)imagePickerController{
    return self.navigationController;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_collectionView setFrame:self.view.bounds];
    [_tableView setFrame:self.view.bounds];
}

- (void) createUI{
    [super createUI];
    
    
    if (self.imagePickerController.titleColor) {
        NSMutableDictionary  * dict= [NSMutableDictionary dictionary];
        [dict setObject:self.imagePickerController.titleColor forKey:NSForegroundColorAttributeName];
        [self.navigationController.navigationBar setTitleTextAttributes:dict];
    }
    
    if (self.imagePickerController.navBackGroundColor) {
        [self.navigationController.navigationBar setBarTintColor:self.imagePickerController.navBackGroundColor];
        [self.navigationController.navigationBar setBackgroundColor:self.imagePickerController.navBackGroundColor];
        [self.navigationController.navigationBar setTranslucent:NO];
        [self.navigationController.navigationBar setShadowImage:[[UIImage new] autorelease]];
    }
    
    if (self.imagePickerController.backBtnColor) {
        [self.navigationController.navigationBar setTintColor:self.imagePickerController.backBtnColor];
    }
    
}

- (void)createRightNavBtn{
    [super createRightNavBtn];
    [_rightNavBtn setTitleColor:self.imagePickerController.rightNavBtnColor forState:UIControlStateNormal];
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
