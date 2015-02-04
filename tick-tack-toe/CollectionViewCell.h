//
//  CollectionViewCell.h
//  tick-tack-toe
//
//  Created by pivotal on 2/3/15.
//  Copyright (c) 2015 blahm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (assign, nonatomic, readonly) BOOL empty;

- (void)displayX;
- (void)displayO;

@end
