//
//  FF_CollectionWaterLayout.m
//  FF_SimpleWaterLayout
//
//  Created by 9188iMac on 16/5/23.
//  Copyright © 2016年 9188iMac. All rights reserved.
//

#import "FF_CollectionWaterLayout.h"

@interface FF_CollectionWaterLayout ()
@property (nonatomic, strong) NSMutableArray *attributeArray;
@property (nonatomic, strong) NSMutableArray *columnHeightArray;
@end

@implementation FF_CollectionWaterLayout

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing{
    if (_minimumLineSpacing != minimumLineSpacing) {
        _minimumLineSpacing = minimumLineSpacing;
        [self invalidateLayout];
    }
}

- (void)setMinimumInteritemSpacing:(CGFloat)minimumInteritemSpacing{
    if (_minimumInteritemSpacing != minimumInteritemSpacing) {
        _minimumInteritemSpacing = minimumInteritemSpacing;
        [self invalidateLayout];
    }
}

- (void)setSectionInset:(UIEdgeInsets)sectionInset{
    if (!UIEdgeInsetsEqualToEdgeInsets(_sectionInset, sectionInset)) {
        _sectionInset = sectionInset;
        [self invalidateLayout];
    }
}

- (void)setNumberOfColumn:(NSInteger)numberOfColumn{
    if (_numberOfColumn != numberOfColumn) {
        _numberOfColumn = numberOfColumn;
        [self invalidateLayout];
    }
}

- (void)prepareLayout{
    [super prepareLayout];
    if (_attributeArray) {
        [_attributeArray removeAllObjects];
    }else{
        self.attributeArray = [NSMutableArray array];
    }
    
    if (_columnHeightArray) {
        [_columnHeightArray removeAllObjects];
    }else{
        self.columnHeightArray = [NSMutableArray array];
    }
    
    for (int i = 0; i < _numberOfColumn; i++) {
        [_columnHeightArray addObject:@(_sectionInset.top)];
    }
    
    CGFloat itemWidth = (self.collectionView.bounds.size.width - _minimumLineSpacing * (_numberOfColumn - 1) - _sectionInset.left - _sectionInset.right) / _numberOfColumn;
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < itemCount; i++) {
        NSInteger minColumn = [self shortColumn];
        CGFloat itemHeight = itemWidth;
        if (_delegate && [_delegate respondsToSelector:@selector(heightOfItems:andHeightOfIndexPath:)]) {
            itemHeight = [_delegate heightOfItems:self andHeightOfIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        CGPoint origin = CGPointMake(_sectionInset.left + (itemWidth + _minimumLineSpacing) * minColumn, [_columnHeightArray[minColumn] floatValue]);
        CGRect rect = CGRectMake(origin.x, origin.y, itemWidth, itemHeight);
        //设置每个collectionview item 在 NSIndexPath 处的 Attributes 属性。
        UICollectionViewLayoutAttributes * attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        attribute.frame = rect;
        [_attributeArray addObject:attribute];
        [_columnHeightArray replaceObjectAtIndex:minColumn withObject:@([_columnHeightArray[minColumn] floatValue] + _minimumLineSpacing + itemHeight)];
    }
    [self.collectionView reloadData];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *marr = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes * attributes in _attributeArray) {
        //判断rect1 是否与 rect2 相交。
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [marr addObject:attributes];
        }
    }
    return marr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _attributeArray[indexPath.row];
}

- (CGSize)collectionViewContentSize{
    NSInteger index = [self longColumn];
    return  CGSizeMake(self.collectionView.bounds.size.width, [_columnHeightArray[index] floatValue] + _sectionInset.bottom - _minimumInteritemSpacing);
}

/**
 *  最短列
 */
- (NSInteger)shortColumn{
    NSInteger index = 0;
    for (int i = 0; i < _numberOfColumn; i++) {
        if ([_columnHeightArray[i] floatValue] < [_columnHeightArray[index] floatValue]) {
            index = i;
        }
    }
    return index;
}
/**
 *  最长列
 */
- (NSInteger)longColumn{
    NSInteger index = 0;
    for (int i = 0; i < _numberOfColumn; i++) {
        if ([_columnHeightArray[i] floatValue] > [_columnHeightArray[index] floatValue]) {
            index = i;
        }
    }
    return index;

}
@end
