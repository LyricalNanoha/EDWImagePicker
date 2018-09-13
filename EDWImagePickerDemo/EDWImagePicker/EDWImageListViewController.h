//
//  EDWImageListViewController.h
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EDWImagePickerBaseViewController.h"
#import <Photos/Photos.h>



@interface EDWImageListViewController : EDWImagePickerBaseViewController

- (instancetype) initWithPHAssetCollection:(PHAssetCollection *)collection;

@property (retain,nonatomic) PHAssetCollection * collection;

@end
