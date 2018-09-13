//
//  EDWImageListViewController.m
//  EDWImagePickerDemo
//
//  Created by mac on 2018/9/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "EDWImageListViewController.h"
#import "EDWImagePickerViewController.h"
#import "EDWImageListCollectionViewCell.h"

@interface EDWImageListViewController ()

@end



@implementation EDWImageListViewController

- (instancetype) initWithPHAssetCollection:(PHAssetCollection *)collection{
    self = [self init];
    if (self) {
        [self setCollection:collection];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createDataSource];
    
    NSLog(@"%lf",self.view.bounds.size.height);
    NSLog(@"%lf",self.view.frame.size.height);
    
    
    [self createCollectionViewWith:UICollectionViewScrollDirectionVertical andCellClass:[EDWImageListCollectionViewCell class] andHeaderClass:nil andFooterClass:nil];
}

- (void) createUI{
    [super createUI];
    [self.navigationItem setTitle:self.collection.localizedTitle];
    [self createRightNavBtn];
}

- (void) createRightNavBtn{
    [super createRightNavBtn];
    [_rightNavBtn setTitleColor:kSystemBlue forState:UIControlStateNormal];
    [_rightNavBtn setTitle:@"确定" forState:UIControlStateNormal];
}

- (void) rightNavBtnClicked:(UIButton *)sender{
    [self.imagePickerController finishChoose];
}

- (void)createDataSource{
    [super createDataSource];
    
    PHFetchOptions * options = [[PHFetchOptions alloc] init];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", PHAssetMediaTypeImage];
    [options setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"creationDate"ascending:NO]]];
    [options setIncludeAssetSourceTypes:PHAssetSourceTypeUserLibrary];
    
    
    PHFetchResult * result = [PHAsset fetchAssetsInAssetCollection:self.collection options:nil];
    
    [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull asset, NSUInteger idx, BOOL * _Nonnull stop) {
        if (asset.mediaType == PHAssetMediaTypeImage) {
            [self.dataSource addObject:asset];
        }
    }];
    
    
    [options release];
    
//    CGFloat multiple = [UIScreen mainScreen].scale;
//    self.imageManager = [[PHCachingImageManager alloc] init];;
//    [self.imageManager setAllowsCachingHighQualityImages:YES];
//    [self.imageManager startCachingImagesForAssets:self.dataSource targetSize:CGSizeMake(kImageWidth * multiple, kImageWidth * multiple) contentMode:PHImageContentModeAspectFill options:nil];
//    [self.imageManager release];
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/4.0-0.5, self.view.frame.size.width/4.0-0.5);
    
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    //    return UIEdgeInsetsZero;
    return UIEdgeInsetsMake(0.5, 0.5, 0.5, 0.5);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

/*
 设置cell
 by 孙越 2015.7.24
 */

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;{
    
    EDWImageListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[EDWImageListCollectionViewCell description] forIndexPath:indexPath];
    [cell setAsset:self.dataSource[indexPath.row]];
    [cell setNumber:[self.imagePickerController indexForAsset:self.dataSource[indexPath.row]]];
    return cell;
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PHAsset * asset = [self.dataSource objectAtIndex:indexPath.row];
    [self.imagePickerController didselectAsset:asset];
    [_collectionView reloadData];
}

- (void)dealloc
{
    self.collection = nil;
    [super dealloc];
}

@end
