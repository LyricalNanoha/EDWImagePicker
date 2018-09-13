//
//  EDWImagePickerViewController.m
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EDWImagePickerViewController.h"
#import "EDWAlbumListViewController.h"
#import "EDWImageListViewController.h"

@interface EDWImagePickerViewController ()

@property (retain,nonatomic) NSMutableArray * dataSource;

@end

@implementation EDWImagePickerViewController

- (instancetype) init{
    EDWAlbumListViewController * albumVC = [[EDWAlbumListViewController alloc] init];
    self = [super initWithRootViewController:albumVC];
    if (self) {
        EDWImageListViewController * imageListVC = [[EDWImageListViewController alloc] initWithPHAssetCollection:albumVC.defaultAssetCollection];
        [self pushViewController:imageListVC animated:NO];
        [imageListVC release];
        
        [self createDataSource];
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) createDataSource{
    self.dataSource =[NSMutableArray array];
}

- (void) didselectAsset:(PHAsset *)asset{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"localIdentifier == %@", asset.localIdentifier];
    NSArray *filteredArray = [self.dataSource filteredArrayUsingPredicate:predicate];
    if (filteredArray.count > 0) {
        PHAsset * selectAsset = (PHAsset *)filteredArray.firstObject;
        [self.dataSource removeObject:selectAsset];
    }else{
        if (self.dataSource.count < self.max || self.max ==0) {
            [self.dataSource addObject:asset];
        }
    }
}

- (NSInteger) indexForAsset:(PHAsset *)asset{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"localIdentifier == %@", asset.localIdentifier];
    NSArray *filteredArray = [self.dataSource filteredArrayUsingPredicate:predicate];
    if (filteredArray.count > 0) {
        return [self.dataSource indexOfObject:asset] + 1;
    }else{
        return 0;
    }
}

- (void) finishChoose{
    if (self.selectImageDelegate && [self.selectImageDelegate respondsToSelector:@selector(EDWImagePickerViewController:didSelectAsset:)]) {
        [self.selectImageDelegate EDWImagePickerViewController:self didSelectAsset:self.dataSource];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIColor *)rightNavBtnColor{
    return _rightNavBtnColor? _rightNavBtnColor:kSystemBlue;
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
