//
//  EDWImagePickerBaseViewController.h
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EDWBaseViewController.h"
#import "EDWImagePickerViewController.h"

@interface EDWImagePickerBaseViewController : EDWBaseViewController

@property (assign,nonatomic,readonly) EDWImagePickerViewController * imagePickerController;

@end
