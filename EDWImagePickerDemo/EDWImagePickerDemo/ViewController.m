//
//  ViewController.m
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ViewController.h"
#import "EDWImagePickerViewController.h"
#import "EDWImagePickerTool.h"

@interface ViewController ()<EDWImagePickerViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createUI{
    [super createUI];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"select" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:btn];
    
}

- (void) btnClicked:(UIButton *)sender{
    EDWImagePickerViewController * imagePicker = [[EDWImagePickerViewController alloc] init];
    [imagePicker setSelectImageDelegate:self];
    [imagePicker setMax:9];
    [imagePicker setTitleColor:[UIColor orangeColor]];
    [imagePicker setNavBackGroundColor:[UIColor cyanColor]];
    [imagePicker setRightNavBtnColor:[UIColor redColor]];
    [imagePicker setBackBtnColor:[UIColor greenColor]];
    [self presentViewController:imagePicker animated:YES completion:nil];
    [imagePicker release];
}

- (void)EDWImagePickerViewController:(EDWImagePickerViewController *)controller didSelectAsset:(NSArray *)assets{
    [EDWImagePickerTool getPhotosWithAssetArrays:assets andMaxSize:240 andFinishHandler:^(NSArray *result) {
        
    }];
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
