//
//  EDImagePickerViewController.h
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDWImageAlbumModel.h"
#import "EDWImagePickerSelectModel.h"

#define kSystemBlue  [UIColor colorWithRed:51.0/255.0 green:123.0/255.0 blue:247.0/255.0 alpha:1]

@class EDWImagePickerViewController;
@protocol  EDWImagePickerViewControllerDelegate<NSObject>

- (void) EDWImagePickerViewController:(EDWImagePickerViewController *)controller didSelectAsset:(NSArray *)assets;

@end

@interface EDWImagePickerViewController : UINavigationController

@property (assign,nonatomic) id<EDWImagePickerViewControllerDelegate>selectImageDelegate;

//- (void) setTitleColor:(UIColor *)color;
//
//- (void) setBackBtnColor:(UIColor *)color;
//
//- (void) setRightNavigationBarBtnColor:(UIColor *)color;
//
//- (void) setNagigationBarBackGroundColor:(UIColor *)color;

@property (copy,nonatomic) UIColor * titleColor;

@property (copy,nonatomic) UIColor * backBtnColor;

@property (copy,nonatomic) UIColor * rightNavBtnColor;

@property (copy,nonatomic) UIColor * navBackGroundColor;

@property (assign,nonatomic) NSInteger max;



- (NSInteger) indexForAsset:(PHAsset *)asset;

- (void) didselectAsset:(PHAsset *)asset;

- (void) finishChoose;



@end
