//
//  ViewController.m
//  FF_SimpleWaterLayout
//
//  Created by 9188iMac on 16/5/23.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "ViewController.h"
#import "FFPresonCoreData.h"
#import "FF_CollectionWaterLayout.h"
@interface ViewController ()<UICollectionViewDataSource, FF_CollectionWaterLayoutDelegate>
@property (nonatomic, strong) FF_CollectionWaterLayout *aFlowLayout;
@property (nonatomic, strong) UICollectionView * aCollectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.aCollectionView];
    
    for (int i = 0; i < 4; i++) {
        [[FFPresonCoreData shareCoreDateManager] write];
    }
    [[FFPresonCoreData shareCoreDateManager] read];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - lazy
- (FF_CollectionWaterLayout *)aFlowLayout{
    if (!_aFlowLayout) {
        _aFlowLayout = [[FF_CollectionWaterLayout alloc] init];
        _aFlowLayout.minimumLineSpacing = 10;
        _aFlowLayout.minimumInteritemSpacing = 10;
        _aFlowLayout.sectionInset = UIEdgeInsetsMake(20, 0, 30, 0);
        _aFlowLayout.numberOfColumn = 3;
        _aFlowLayout.delegate = self;
    }
    return  _aFlowLayout;
}

- (UICollectionView *)aCollectionView{
    if (!_aCollectionView) {
        _aCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.aFlowLayout];
        _aCollectionView.backgroundColor = [UIColor whiteColor];
        [_aCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"tcell"];
        _aCollectionView.dataSource = self;
    }
    return _aCollectionView;
}

#pragma mark - datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tcell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:(arc4random() % 255) / 255.0 green:(arc4random() % 255) / 255.0 blue:(arc4random() % 255) / 255.0 alpha:1.0];
    return cell;
}

#pragma mark - delegate
- (CGFloat)heightOfItems:(FF_CollectionWaterLayout *)layout andHeightOfIndexPath:(NSIndexPath *)indexPath{
    return (arc4random() % 200) + 100;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
