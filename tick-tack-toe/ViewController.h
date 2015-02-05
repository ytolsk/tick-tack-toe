//
//  ViewController.h
//  tick-tack-toe
//
//  Created by pivotal on 2/3/15.
//  Copyright (c) 2015 blahm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PlayerTypeX = 0,
    PlayerTypeO,
    PlayerTypeNone,
} PlayerType;


@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
