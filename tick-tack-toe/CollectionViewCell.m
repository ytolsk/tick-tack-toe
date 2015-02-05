//
//  CollectionViewCell.m
//  tick-tack-toe
//
//  Created by pivotal on 2/3/15.
//  Copyright (c) 2015 blahm. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (assign, nonatomic) BOOL empty;

@end


@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.empty = YES;
}

- (void)displayX {
    self.label.text = @"X";
    self.empty = NO;
}

- (void)displayO {
    self.label.text = @"O";
    self.empty = NO;
}

- (void)reset {
    self.label.text = nil;
    self.empty = YES;
}

@end
